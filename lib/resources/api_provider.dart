import 'dart:convert';
import 'package:grpc_server/core/model/categories.dart';
import 'package:grpc_server/core/model/products.dart';
import 'package:grpc_server/core/model/repair.dart';
import 'package:grpc_server/resources/local_store.dart';
import 'package:http/http.dart' as http;

class DataProvider {
  final LocalStoreSettings store = LocalStoreSettings();

  Future<List<Product>> fetchProducts(int idCategory,
      [int startIndex = 0]) async {
    String SERVER_ADRESS = await store.getValue('SERVER_ADRESS') ?? '';
    int LIMIT_PRODUCT = await store.getValue('LIMIT_PRODUCT') ?? 50;

    final response = await http.Client().get(
      Uri.http(
        SERVER_ADRESS,
        '/api/v1/get-products',
        <String, String>{
          'category-code': idCategory.toString(),
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
          idCategory: idCategory,
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

  Future<List<Categories>> fetchCategories([int startIndex = 0]) async {
    final String SERVER_ADRESS = await store.getValue('SERVER_ADRESS');

    final response = await http.Client().get(
      Uri.http(SERVER_ADRESS, '/api/v1/get-categories'),
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        final map = json as Map<String, dynamic>;
        return Categories(
          id: map['Code'] as int,
          title: map['Description'] as String,
        );
      }).toList();
    }
    throw Exception('error fetching posts');
  }

  Future<Map<String, dynamic>> fetchProductInfo(int code) async {
    final String SERVER_ADRESS = await store.getValue('SERVER_ADRESS');

    final response = await http.get(
      Uri.http(
        SERVER_ADRESS,
        '/api/v2/product',
        <String, String>{
          'code': code.toString(),
        },
      ),
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      // final List<dynamic> listImages = body!['images'];
      // Image img;

      for (int index = 0; index <= body!['images'].length - 1; index++) {
        //   final img = await _fetchImage(listImages[index]);
        //   // .then((value) => body!['images'][index] = value);
        body!['images'][index] =
            'http://$SERVER_ADRESS${body!['images'][index]}';
      }

      return body;
    }
    throw Exception('Ошибка получения данных товара');
  }

  Future<List<Repair>> fetchAllRepairs([int startIndex = 0]) async {
    String SERVER_ADRESS = await store.getValue('SERVER_ADRESS') ?? '';

    final response = await http.Client().get(
      Uri.http(
        SERVER_ADRESS,
        '/api/v1/repairs?Last&show-all',
        <String, String>{},
      ),
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        final map = json as Map<String, dynamic>;

        return Repair(
          code: map['code_record']!.toInt() ?? 0,
          dateReceipt: map['code_record']!.toString(),
          numberReceipt: map['code_record']!.toInt() ?? 0,
          paid: map['paid']!,
        );
      }).toList();
    }
    throw Exception('Ошибка получения товаров');
  }

  Future<List<Repair>> fetchRepairsNoPay() async {
    String SERVER_ADRESS = await store.getValue('SERVER_ADRESS') ?? '';

    final response = await http.Client().get(
      Uri.http(
        SERVER_ADRESS,
        '/api/v1/repairs?Last',
        <String, String>{},
      ),
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        final map = json as Map<String, dynamic>;

        return Repair(
          code: map['code_record']!.toInt() ?? 0,
          dateReceipt: map['code_record']!.toString(),
          numberReceipt: map['code_record']!.toInt() ?? 0,
          paid: map['paid']!,
        );
      }).toList();
    }
    throw Exception('Ошибка получения товаров');
  }
}
