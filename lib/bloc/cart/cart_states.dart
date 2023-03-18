part of 'cart_bloc.dart';

enum CartStatus { initial, success, error, pay, empty, cancel }

class CartState extends Equatable {
  const CartState({
    this.status = CartStatus.initial,
    this.items = const <CartItem>[],
    this.totalCount = 0,
    this.totalPrice = 0,
  });

  final CartStatus status;
  final List<CartItem> items;
  final int totalCount;
  final double totalPrice;

  CartState copyWith(
      {CartStatus? status,
      List<CartItem>? items,
      int? totalCount,
      double? totalPrice}) {
    return CartState(
        status: status ?? this.status,
        items: items ?? this.items,
        totalCount: totalCount ?? this.totalCount,
        totalPrice: totalPrice ?? this.totalPrice);
  }

  @override
  String toString() {
    return '''CartState { status: $status,  products: ${items.length}, count: $totalCount, price: $totalPrice }''';
  }

  @override
  List<Object> get props => [status, items, totalCount, totalPrice];
}
