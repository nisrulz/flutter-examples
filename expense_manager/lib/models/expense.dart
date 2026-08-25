import 'package:expense_manager/constants.dart';
import 'package:expense_manager/index.dart';
import 'package:expense_manager/models/serializable.dart';
import 'package:expense_manager/models/tag.dart';
import 'package:expense_manager/models/transaction.dart';
import 'package:isar/isar.dart';
import 'category.dart';

part 'expense.g.dart';

@collection
@JsonSerializable()
class Expense extends Transaction implements Serializable {
  final category = IsarLink<Category>();
  final tags = IsarLinks<Tag>();

  Expense({
    super.amountCents,
    super.note,
    super.isAdHoc,
    super.weekDay,
    super.accountId,
  });

  bool get isNew => id == null;

  static Future<Expense> fromJson(json) async {
    json['attachments'] = json['attachments'] ?? <String>[];

    final obj = _$ExpenseFromJson(json);
    if (json['category'] != null) {
      final cat = await Category.fromJson(json['category']);
      await kCategoryRepo.save(cat);
      obj.category.value = cat;
    }
    for (var element in json['tags'] ?? []) {
      final tag = await Tag.fromJson(element);
      await kTagRepo.save(tag);
      obj.tags.add(tag);
    }
    return obj;
  }

  @override
  Map<String, dynamic> toJson({bool includeLinks = false}) {
    final json = _$ExpenseToJson(this);
    if (includeLinks) {
      category.loadSync();
      tags.loadSync();
      json['category'] = category.value?.toJson();
      json['tags'] = tags.map((e) => e.toJson()).toList();
    }
    return json;
  }
}
