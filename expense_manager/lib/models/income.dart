import 'package:expense_manager/index.dart';
import 'package:expense_manager/models/serializable.dart';
import 'package:expense_manager/models/transaction.dart';
import 'package:isar/isar.dart';

part 'income.g.dart';

@collection
@JsonSerializable()
class Income extends Transaction implements Serializable {
  Income({
    super.amountCents,
    super.note,
    super.isAdHoc,
    super.accountId,
  });

  factory Income.fromJson(json) {
    final obj = _$IncomeFromJson(json);
    return obj;
  }

  @override
  Map<String, dynamic> toJson({bool includeLinks = false}) {
    return _$IncomeToJson(this);
  }
}
