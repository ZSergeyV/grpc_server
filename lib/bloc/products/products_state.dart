part of 'products_bloc.dart';

enum ProductsStatus { initial, success, failure }

class ProductsState extends Equatable {
  const ProductsState({
    this.status = ProductsStatus.initial,
    this.products = const <Product>[],
    this.hasReachedMax = false,
  });

  final ProductsStatus status;
  final List<Product> products;
  final bool hasReachedMax;

  ProductsState copyWith({
    ProductsStatus? status,
    List<Product>? products,
    bool? hasReachedMax,
  }) {
    return ProductsState(
      status: status ?? this.status,
      products: products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${products.length} }''';
  }

  @override
  List<Object> get props => [status, products, hasReachedMax];
}
