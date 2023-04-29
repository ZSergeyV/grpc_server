import 'dart:convert';
import 'package:grpc_server/core/model/products.dart';
import 'package:grpc_server/resources/local_store.dart';
import 'package:http/http.dart' as http;

class DataProvider {
  final LocalStoreSettings store = LocalStoreSettings();

  Future<List<Product>> fetchProducts(int igCategory,
      [int startIndex = 0]) async {
    String SERVER_ADRESS = await store.getValue('SERVER_ADRESS') ?? '';
    int LIMIT_PRODUCT = await store.getValue('LIMIT_PRODUCT') ?? 50;

    final response = await http.Client().get(
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
        final urlThumbImage = map['thumb'] != ''
            ? 'http://$SERVER_ADRESS/static/images/thumbnail/${map['thumb']}'
            : '';
        return Product(
          code: map['Code'] ?? 0,
          idCategory: igCategory,
          name: map['name'] ?? '',
          price: map['price']!.toDouble() ?? 0,
          quantityStock: map['quantity_stock'] ?? 0,
          quantityStore: map['quantity_store'] ?? 0,
          storageCell: (map['storage_cell'] ?? '').replaceAll('\n', ''),
          storageCellStock:
              (map['storage_cell_stock'] ?? '').replaceAll('\n', ''),
          thumb: urlThumbImage,
        );
      }).toList();
    }
    throw Exception('Ошибка получения товаров');
  }
}
