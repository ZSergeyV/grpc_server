import 'package:equatable/equatable.dart';
import 'package:grpc_server/core/model/products.dart';

// class Cart extends Equatable {
//   const Cart({
//     required this.items,
//     required this.totalCount,
//     required this.totalPrice,
//   });

//   final List<CartItem> items;
//   final int totalCount;
//   final double totalPrice;

//   @override
//   List<Object> get props => [items, totalCount];
// }

class CartItem extends Equatable {
  const CartItem(
      {required this.product, required this.count, required this.price});
  final Product product;
  final double price;
  final int count;

  //set changeCount(int value) => count = count + value;
  // factory cartItemFrom (Product product){
  //   return CartItem(product: product, count: count, price: price)
  // }

  @override
  List<Object> get props => [product, count, price];
}
