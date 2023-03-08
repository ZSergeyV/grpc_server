part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddProduct extends CartEvent {}

class DeleteProduct extends CartEvent {}

class ClearProduct extends CartEvent {}
