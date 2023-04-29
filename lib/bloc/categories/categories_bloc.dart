import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:grpc_server/core/model/categories.dart';
import 'package:grpc_server/resources/api_repository.dart';
import 'package:equatable/equatable.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc({required this.repository}) : super(const CategoriesState()) {
    on<CategoriesFetched>(_onCategoriesFetched);
  }

  final DataRepository repository;

  Future<void> _onCategoriesFetched(
      CategoriesFetched event, Emitter<CategoriesState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == CategoriesStatus.initial) {
        final categories = await repository.getCategories();
        return emit(state.copyWith(
          status: CategoriesStatus.success,
          categories: categories,
          hasReachedMax: false,
        ));
      }
      final categories =
          await repository.getCategories(state.categories.length);
      emit(categories.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: CategoriesStatus.success,
              categories: List.of(state.categories)..addAll(categories),
              hasReachedMax: false,
            ));
    } catch (_) {
      emit(state.copyWith(status: CategoriesStatus.failure));
    }
  }
}
