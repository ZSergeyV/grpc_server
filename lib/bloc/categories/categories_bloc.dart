import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:grpc_server/core/model/categories.dart';
import 'package:grpc_server/resources/local_store.dart';
// import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:equatable/equatable.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc({required this.store, required this.httpClient})
      : super(const CategoriesState()) {
    on<CategoriesFetched>(_onCategoriesFetched);
  }

  final http.Client httpClient;
  final LocalStoreSettings store;

  Future<void> _onCategoriesFetched(
      CategoriesFetched event, Emitter<CategoriesState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == CategoriesStatus.initial) {
        final categories = await _fetchCategories();
        return emit(state.copyWith(
          status: CategoriesStatus.success,
          categories: categories,
          hasReachedMax: false,
        ));
      }
      final categories = await _fetchCategories(state.categories.length);
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

  Future<List<Categories>> _fetchCategories([int startIndex = 0]) async {
    final String SERVER_ADRESS = await store.getValue('SERVER_ADRESS');

    final response = await httpClient.get(
      Uri.http(SERVER_ADRESS, '/api/v1/get-categories'),
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        final map = json as Map<String, dynamic>;
        return Categories(
          id: map['Code'] as int,
          title: map['Description'] as String,
        );
      }).toList();
    }
    throw Exception('error fetching posts');
  }
}
