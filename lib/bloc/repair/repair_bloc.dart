import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc_server/core/model/repair.dart';
import 'package:grpc_server/resources/api_repository.dart';

part 'repair_states.dart';
part 'repair_events.dart';

class RepairBloc extends Bloc<RepairEvent, RepairState> {
  RepairBloc({required this.repository}) : super(const RepairState()) {
    on<FetchedAllRepairs>(_onFetcheAllRepairs);
    on<FetchedNoPayRepairs>(_onFetcheNoPayRepairs);
  }

  final DataRepository repository;

  Future<void> _onFetcheAllRepairs(
      FetchedAllRepairs event, Emitter<RepairState> emit) async {
    try {
      if (state.status == RepairStatus.initial) {
        final repairs = await repository.getAllRepairs();
        return emit(state.copyWith(
          status: RepairStatus.success,
          repairs: repairs,
        ));
      }
      final repairs = await repository.getAllRepairs();
      emit(state.copyWith(
        status: RepairStatus.success,
        repairs: List.of(state.repairs)..addAll(repairs),
      ));
    } catch (_) {
      emit(state.copyWith(status: RepairStatus.failure));
    }
  }

  Future<void> _onFetcheNoPayRepairs(
      FetchedNoPayRepairs event, Emitter<RepairState> emit) async {
    try {
      if (state.status == RepairStatus.initial) {
        final repairs = await repository.getRepairsNoPay();
        return emit(state.copyWith(
          status: RepairStatus.success,
          repairs: repairs,
        ));
      }
      final repairs = await repository.getRepairsNoPay();
      emit(state.copyWith(
        status: RepairStatus.success,
        repairs: List.of(state.repairs)..addAll(repairs),
      ));
    } catch (_) {
      emit(state.copyWith(status: RepairStatus.failure));
    }
  }
}
