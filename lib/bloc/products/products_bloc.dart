import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
// import 'package:grpc_server/config/config.dart';
import 'package:grpc_server/core/model/products.dart';
import 'package:grpc_server/resources/local_store.dart';
// import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc({required this.store, required this.httpClient})
      : super(const ProductsState()) {
    on<ProductsFetched>(_onProductsFetched);
  }

  final http.Client httpClient;
  final LocalStoreSettings store;

  Future<void> _onProductsFetched(
      ProductsFetched event, Emitter<ProductsState> emit) async {
    final int productLenght = state.products.length;
    if (state.hasReachedMax) return;
    try {
      if (state.status == ProductsStatus.initial) {
        final products = await _fetchProducts(event.idCategory, productLenght);
        return emit(state.copyWith(
          status: ProductsStatus.success,
          products: products,
          hasReachedMax: false,
        ));
      }
      final products = await _fetchProducts(event.idCategory, productLenght);
      emit(products.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: ProductsStatus.success,
              products: List.of(state.products)..addAll(products),
              hasReachedMax: false,
            ));
    } catch (_) {
      emit(state.copyWith(status: ProductsStatus.failure));
    }
  }

  Future<List<Product>> _fetchProducts(int igCategory,
      [int startIndex = 0]) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String SERVER_ADRESS = prefs.getString('SERVER_ADRESS') ?? '';
    int LIMIT_PRODUCT = prefs.getInt('LIMIT_PRODUCT') ?? 50;

    final response = await httpClient.get(
      Uri.http(
        SERVER_ADRESS,
        '/api/v1/get-products',
        <String, String>{
          'category-code': igCategory.toString(),
          'skip': '$startIndex',
          'count': '$LIMIT_PRODUCT'
        },
      ),
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        final map = json as Map<String, dynamic>;
        return Product(
          code: map['Code'] ?? 0,
          idCategory: igCategory,
          name: map['name'] ?? '',
          price: map['price']!.toDouble() ?? 0,
          quantityStock: map['quantity_stock'] ?? 0,
          quantityStore: map['quantity_store'] ?? 0,
          storageCell: map['storage_cell'] ?? '',
          storageCellStock: map['storage_cell_stock'] ?? '',
          thumb: map['thumb'] ?? '',
        );
      }).toList();
    }
    throw Exception('Ошибка получения товаров');
  }
}
