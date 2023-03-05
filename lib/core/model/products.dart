import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product(
      {required this.code,
      required this.idCategory,
      required this.name,
      required this.price,
      required this.quantityStock,
      required this.quantityStore,
      required this.storageCell,
      required this.storageCellStock,
      required this.thumb});

  final int code;
  final int idCategory;
  final String name;
  final double price;
  final int quantityStock;
  final int quantityStore;
  final String storageCell;
  final String storageCellStock;
  final String thumb;

  @override
  List<Object> get props => [code, name];
}
