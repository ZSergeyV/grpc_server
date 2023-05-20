import 'package:equatable/equatable.dart';

class Repair extends Equatable {
  Repair(
      {required this.code,
      required this.dateReceipt,
      required this.numberReceipt,
      required this.paid});
  final int code;
  final String dateReceipt;
  final int numberReceipt;
  final bool paid;

  @override
  List<Object> get props => [code, numberReceipt];
}
