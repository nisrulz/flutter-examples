import 'package:expense_manager/index.dart';
import 'package:isar/isar.dart';

abstract class Transaction {
  Id? id;
  int amountCents = 0;
  String note = "";
  DateTime date = DateTime.now();
  int weekDay = 0;
  bool isAdHoc = false;
  int? accountId;

  @ignore
  @JsonKey(includeFromJson: false, includeToJson: false)
  int year = 0;

  @ignore
  @JsonKey(includeFromJson: false, includeToJson: false)
  int month = 0;

  @ignore
  @JsonKey(includeFromJson: false, includeToJson: false)
  double get amount => amountCents / 100;

  Transaction({
    this.amountCents = 0,
    this.note = "",
    this.isAdHoc = false,
    this.weekDay = 0,
    this.accountId,
  });
}
