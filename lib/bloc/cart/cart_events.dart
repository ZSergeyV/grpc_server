part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddProduct extends CartEvent {
  final Product product;
  AddProduct(this.product);
}

class DeleteProduct extends CartEvent {
  final CartItem item;
  DeleteProduct(this.item);
}

class ChangeCountProduct extends CartEvent {
  final CartItem item;
  final int count;
  ChangeCountProduct(this.item, this.count);
}

class ClearProduct extends CartEvent {}
