import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc_server/core/model/repair.dart';
import 'package:grpc_server/resources/api_repository.dart';

part 'repair_states.dart';
part 'repair_events.dart';

class RepairBloc extends Bloc<RepairEvent, RepairState> {
  RepairBloc({required this.repository}) : super(const RepairState()) {
    on<RepairFetched>(_onFetcheRepairs);
  }

  final DataRepository repository;

  Future<void> _onFetcheRepairs(
      RepairFetched event, Emitter<RepairState> emit) async {
    final int repairLenght = state.repairs.length;
    try {
      if (state.status == RepairStatus.initial) {
        final repairs = await repository.getRepairs(repairLenght);
        return emit(state.copyWith(
          status: RepairStatus.success,
          repairs: repairs,
          hasReachedMax: false,
        ));
      }
      final repairs = await repository.getRepairs(repairLenght);
      emit(repairs.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: RepairStatus.success,
              repairs: List.of(state.repairs)..addAll(repairs),
              hasReachedMax: false,
            ));
    } catch (_) {
      emit(state.copyWith(status: RepairStatus.failure));
    }
  }
}
