part of 'cart_bloc.dart';

enum CartStatus { initial, success, error, pay, clear, cancel }

class CartState extends Equatable {
  const CartState({
    this.status = CartStatus.initial,
    this.products = const <Product>[],
  });

  final CartStatus status;
  final List<Product> products;

  CartState copyWith({
    CartStatus? status,
    List<Product>? categories,
  }) {
    return CartState(
      status: status ?? this.status,
      products: products,
    );
  }

  @override
  String toString() {
    return '''CartState { status: $status,  products: ${products.length} }''';
  }

  @override
  List<Object> get props => [status, products];
}
