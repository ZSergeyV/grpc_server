part of 'categories_bloc.dart';

abstract class CategoriesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CategoriesFetched extends CategoriesEvent {}
