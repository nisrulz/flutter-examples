import 'package:expense_manager/misc/extensions.dart';
import 'package:expense_manager/constants.dart';
import 'package:expense_manager/index.dart';
import 'package:expense_manager/models/expense.dart';
import 'package:expense_manager/models/serializable.dart';
import 'package:isar/isar.dart';

part 'tag.g.dart';

@collection
@JsonSerializable()
class Tag implements Serializable {
  Id? id;
  late String name;
  String? colorCode;

  final expenses = IsarLinks<Expense>();

  @ignore
  bool isFromRemark = false;

  @ignore
  int amount = 0;

  @ignore
  int get totalAmountCents => expenses.toList().sumAmounts();

  Tag();

  Tag.create({
    required this.name,
    this.id,
    this.colorCode,
    this.isFromRemark = false,
  });

  static Future<Tag> fromJson(json, {bool includeLinks = true}) async {
    final obj = _$TagFromJson(json);

    if (includeLinks) {
      for (var element in json['expenses'] ?? []) {
        final expense = await Expense.fromJson(element);
        await kExpenseRepo.save(expense);
        obj.expenses.add(expense);
      }
    }
    return obj;
  }

  Future<List<Expense>> expensesBetweenDates(
      {DateTime? start, DateTime? end}) async {
    if (start == null || end == null) {
      return (await expenses.filter().findAll()).toList();
    }
    return expenses.filter().dateBetween(start, end).findAll();
  }

  @override
  Map<String, dynamic> toJson({bool includeLinks = false}) {
    final json = _$TagToJson(this);
    if (includeLinks) {
      expenses.loadSync();
      json['expenses'] = expenses.map((e) => e.toJson()).toList();
    }
    return json;
  }
}
