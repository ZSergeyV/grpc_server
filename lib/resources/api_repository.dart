import 'package:grpc_server/core/model/products.dart';
import 'package:grpc_server/resources/api_provider.dart';

class DataRepository {
  final provider = DataProvider();

  Future<List<Product>> getProducts(int idCategory, [int startIndex = 0]) =>
      provider.fetchProducts(idCategory, startIndex);
}
