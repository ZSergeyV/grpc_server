import 'package:equatable/equatable.dart';

class Categories extends Equatable {
  const Categories({required this.id, required this.title});

  final int id;
  final String title;

  @override
  List<Object> get props => [id, title];
}
