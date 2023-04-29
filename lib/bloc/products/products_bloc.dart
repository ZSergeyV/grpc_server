import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:grpc_server/core/model/products.dart';
import 'package:grpc_server/resources/api_repository.dart';
import 'package:equatable/equatable.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc({required this.repository}) : super(const ProductsState()) {
    on<ProductsFetched>(_onProductsFetched);
  }

  final DataRepository repository;

  Future<void> _onProductsFetched(
      ProductsFetched event, Emitter<ProductsState> emit) async {
    final int productLenght = state.products.length;
    if (state.hasReachedMax) return;
    try {
      if (state.status == ProductsStatus.initial) {
        final products =
            await repository.getProducts(event.idCategory, productLenght);
        return emit(state.copyWith(
          status: ProductsStatus.success,
          products: products,
          hasReachedMax: false,
        ));
      }
      final products =
          await repository.getProducts(event.idCategory, productLenght);
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
}
