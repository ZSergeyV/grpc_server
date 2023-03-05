part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductsFetched extends ProductsEvent {
  final int idCategory;

  ProductsFetched(this.idCategory, int length);
}
