part of 'categories_bloc.dart';

enum CategoriesStatus { initial, success, failure }

class CategoriesState extends Equatable {
  const CategoriesState({
    this.status = CategoriesStatus.initial,
    this.categories = const <Categories>[],
    this.hasReachedMax = false,
  });

  final CategoriesStatus status;
  final List<Categories> categories;
  final bool hasReachedMax;

  CategoriesState copyWith({
    CategoriesStatus? status,
    List<Categories>? categories,
    bool? hasReachedMax,
  }) {
    return CategoriesState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${categories.length} }''';
  }

  @override
  List<Object> get props => [status, categories, hasReachedMax];
}
