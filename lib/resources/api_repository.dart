import 'package:grpc_server/core/model/categories.dart';
import 'package:grpc_server/core/model/products.dart';
import 'package:grpc_server/core/model/repair.dart';
import 'package:grpc_server/resources/api_provider.dart';

class DataRepository {
  final provider = DataProvider();

  Future<List<Product>> getProducts(int idCategory, [int startIndex = 0]) =>
      provider.fetchProducts(idCategory, startIndex);

  Future<List<Categories>> getCategories([int startIndex = 0]) =>
      provider.fetchCategories(startIndex);

  Future<Map<String, dynamic>> getProductInfo(int code) =>
      provider.fetchProductInfo(code);

  Future<List<Repair>> getRepairs([int startIndex = 0]) =>
      provider.fetchRepairs(startIndex);
}
