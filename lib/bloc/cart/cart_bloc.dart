import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc_server/core/model/products.dart';

part 'cart_events.dart';
part 'cart_states.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<AddProduct>(_onAddCartProduct);
    on<DeleteProduct>(_onDeleteCartProduct);
    on<ClearProduct>(_onClearCart);
  }

  Future<void> _onAddCartProduct(
      AddProduct event, Emitter<CartState> emit) async {
    //final int productLenght = state.products.length;
    final List<Product> products = List.from(state.products)
      ..add(event.product);
    //products.add(event.product);

    return emit(state.copyWith(
      status: CartStatus.initial,
      products: products,
    ));

    // try {
    //   if (state.status == ProductsStatus.initial) {
    //     final products = await _fetchProducts(event.idCategory, productLenght);
    //     return emit(state.copyWith(
    //       status: ProductsStatus.success,
    //       products: products,
    //       hasReachedMax: false,
    //     ));
    //   }
    //   final products = await _fetchProducts(event.idCategory, productLenght);
    //   emit(products.isEmpty
    //       ? state.copyWith(hasReachedMax: true)
    //       : state.copyWith(
    //           status: ProductsStatus.success,
    //           products: List.of(state.products)..addAll(products),
    //           hasReachedMax: false,
    //         ));
    // } catch (_) {
    //   emit(state.copyWith(status: ProductsStatus.failure));
    // }
  }

  Future<void> _onDeleteCartProduct(
      DeleteProduct event, Emitter<CartState> emit) async {}

  Future<void> _onClearCart(ClearProduct event, Emitter<CartState> emit) async {
    return emit(state.copyWith(
      status: CartStatus.initial,
      products: [],
    ));
  }
}
