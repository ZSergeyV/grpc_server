part of 'repair_bloc.dart';

abstract class RepairEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddRepair extends RepairEvent {
  final Repair repair;
  AddRepair(this.repair);
}

class DeleteRepair extends RepairEvent {
  final Repair repair;
  DeleteRepair(this.repair);
}

class EditRepair extends RepairEvent {
  final Repair repair;
  EditRepair(this.repair);
}

class RepairFetched extends RepairEvent {
  RepairFetched([int length = 0]);
}
