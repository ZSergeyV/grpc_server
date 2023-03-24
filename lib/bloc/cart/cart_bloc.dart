import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc_server/core/model/cart.dart';
import 'package:grpc_server/core/model/products.dart';

part 'cart_events.dart';
part 'cart_states.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<AddProduct>(_onAddCartProduct);
    on<ChangeCountProduct>(_onChangeCountProduct);
    on<DeleteProduct>(_onDeleteCartProduct);
    on<ClearProduct>(_onClearCart);

    // CartBloc cartBloc = CartBloc();
  }

  Future<void> _onAddCartProduct(
      AddProduct event, Emitter<CartState> emit) async {
    //final int productLenght = state.products.length;

    // Проверим есть ли данный товар в корзине
    int itemCount = 0, index = 0;
    double itemPrice = 0, totalPrice = 0;
    List<CartItem> items = state.items;

    CartItem newItemCart =
        CartItem(product: event.product, count: 1, price: event.product.price);

    for (var element in state.items) {
      if (element.product == event.product) {
        itemCount = element.count + 1;
        itemPrice = element.price + event.product.price;

        items[index] = CartItem(
            product: event.product, count: itemCount, price: itemPrice);
      }
      index++;
    }

    if (itemCount == 0 && itemPrice == 0) {
      items = List.from(state.items)..add(newItemCart);
    }

    for (var element in items) {
      totalPrice = totalPrice + element.price;
    }
    return emit(state.copyWith(
        status: CartStatus.initial,
        items: items,
        totalCount: items.length,
        totalPrice: totalPrice));
  }

  Future<void> _onChangeCountProduct(
      ChangeCountProduct event, Emitter<CartState> emit) async {
    List<CartItem> items = state.items;
    int index = 0, itemCount = 0;
    double itemPrice = 0, totalPrice = 0;

    for (var element in state.items) {
      if (element == event.item) {
        itemCount = event.count;
        itemPrice = event.count * event.item.product.price;

        items[index] = CartItem(
            product: event.item.product, count: itemCount, price: itemPrice);
      }
      index++;
    }

    // for (var element in items) {
    //   totalPrice = totalPrice + element.price;
    // }
    totalPrice = _totalSum(items);

    return emit(state.copyWith(
        status: CartStatus.initial,
        items: items,
        totalCount: state.totalCount,
        totalPrice: totalPrice));
  }

  Future<void> _onDeleteCartProduct(
      DeleteProduct event, Emitter<CartState> emit) async {
    List<CartItem> items = state.items;
    double totalPrice = 0;

    items.removeWhere((element) => element == event.item);

    final CartStatus returnStatus =
        items.isEmpty ? CartStatus.empty : CartStatus.initial;
    totalPrice = items.isEmpty ? 0 : _totalSum(items);

    return emit(state.copyWith(
        status: returnStatus,
        items: items,
        totalCount: items.length,
        totalPrice: totalPrice));
  }

  Future<void> _onClearCart(ClearProduct event, Emitter<CartState> emit) async {
    return emit(state.copyWith(
        status: CartStatus.empty, items: [], totalCount: 0, totalPrice: 0));
  }

  Map<String, dynamic> productInCart(Product product) {
    Map<String, dynamic> result = {'isCart': false};
    final resultFound =
        state.items.where((element) => element.product == product);
    if (resultFound.isNotEmpty) {
      result['isCart'] = true;
      result['count'] = resultFound.first.count;
    }
    return result;
  }

  double _totalSum(List<CartItem> items) => items
      .map<double>((e) => e.price)
      .reduce((value, element) => value + element);
}
