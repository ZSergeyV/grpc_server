part of 'repair_bloc.dart';

enum RepairStatus { initial, success, failure }

class RepairState extends Equatable {
  const RepairState(
      {this.status = RepairStatus.initial, this.repairs = const <Repair>[]});

  final RepairStatus status;
  final List<Repair> repairs;

  RepairState copyWith({
    RepairStatus? status,
    List<Repair>? repairs,
  }) {
    return RepairState(
      status: status ?? this.status,
      repairs: repairs ?? this.repairs,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, posts: ${repairs.length} }''';
  }

  @override
  List<Object> get props => [status, repairs];
}
