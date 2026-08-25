import 'package:expense_manager/constants.dart';
import 'package:expense_manager/index.dart';
import 'package:expense_manager/models/serializable.dart';
import 'package:expense_manager/misc/extensions.dart';
import 'package:isar/isar.dart';
import 'expense.dart';

part 'category.g.dart';

@collection
@JsonSerializable()
class Category implements Serializable {
  Id? id;
  String? name;
  String? colorCode;
  int iconId = 0;
  int priority = 0;
  int budgetCents = 0;

  @Backlink(to: 'category')
  final expenses = IsarLinks<Expense>();

  @ignore
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool isSelected = false;

  @ignore
  @JsonKey(includeFromJson: false, includeToJson: false)
  double get budget => budgetCents / 100;

  @ignore
  int amount = 0;

  Category({
    this.name,
    this.colorCode,
    this.iconId = 0,
    this.priority = 0,
    this.budgetCents = 0,
  });

  @ignore
  int get totalAmountCents => expenses.toList().sumAmounts();

  static Future<Category> fromJson(json) async {
    final obj = _$CategoryFromJson(json);
    await kCategoryRepo.save(obj);

    final List<Future<Expense>> mExpenses = json['expenses']
            ?.map<Future<Expense>>((e) async => await Expense.fromJson(e))
            .toList() ??
        [];
    for (var element in obj.expenses) {
      await kExpenseRepo.save(element);
    }

    for (var element in mExpenses) {
      obj.expenses.add(await element);
    }

    await obj.expenses.saveWithTrnx();
    return obj;
  }

  @override
  Map<String, dynamic> toJson({bool includeLinks = false}) {
    final json = _$CategoryToJson(this);
    if (includeLinks) {
      expenses.loadSync();
      json['expenses'] = expenses.map((e) => e.toJson()).toList();
    }
    return json;
  }
}
