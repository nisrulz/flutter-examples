import 'package:expense_manager/constants.dart';
import 'package:expense_manager/models/expense.dart';
import 'package:expense_manager/models/income.dart';
import 'package:expense_manager/models/transaction.dart';
import '../models/tag.dart';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'utils.dart';
import 'dart:math' as math;
import 'package:isar/isar.dart';

extension TransactionListParsing on List<Transaction> {
  int sumAmounts() => fold(0, (total, element) => total + element.amountCents);
}

extension TransactionParsing on Transaction {
  Transaction clone() {
    if (id == null) return this;

    if (this is Expense) {
      return kExpenseRepo.findSync(id!)!;
    } else if (this is Income) {
      return kIncomeRepo.findSync(id!)!;
    }

    throw "Unknown transaction for cloning";
  }
}

extension ExpenseParsing on Expense {
  Future<void> saveTags(
    List<Tag> tagsToRemove,
    List<Tag> newTags, {
    bool transaction = true,
  }) async {
    if (tagsToRemove.isNotEmpty) {
      tags.removeAll(tagsToRemove);
    }

    if (newTags.isNotEmpty) {
      tags.addAll(newTags);
    }
    await kExpenseRepo.save(this, transaction: transaction);
  }
}

extension IntParsing on int {
  String toMoney({String? currency}) {
    return formatMoney(this / 100, currency: currency ?? kCurrency);
  }
}

extension DoubleParsing on double {
  String shortForm() {
    if (this >= 10000) return "${this ~/ 1000}K";
    if (this >= 1000) return "${(this / 1000).toStringAsFixed(0)}K";
    return toInt().toString();
  }
}

extension ColorParsing on Color {
  String toHex() =>
      '#${(value & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';
}

extension DateTimeParsing on DateTime {
  DateTime startDate() => copyWith(
      day: 1, hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
  DateTime endDate() =>
      copyWith(month: month + 1, day: 0, hour: 23, minute: 59, second: 59);
  DateTime lastMonth({int numOfMonth = 1}) =>
      copyWith(month: month - numOfMonth, day: 1);
  DateTime nextMonth({int numOfMonth = 1}) =>
      copyWith(month: month + numOfMonth, day: 1);
  bool isSameMonthAs(DateTime dt) => year == dt.year && month == dt.month;
  String format(String dateFormat) => DateFormat(dateFormat).format(this);
}

extension DoubleListParsing on List<double> {
  double min() => reduce(math.min);
}

extension ListParsing on List {
  bool isLargerThan(List list) => length > list.length;
  bool isSameSizeAs(List list) => length == list.length;
}

extension StringParsing on String {
  void clear() => this == '';
}

/// Extension specifically for isar package
Isar get _isar {
  if (Isar.getInstance() == null) throw "Isar instance is not found";
  return Isar.getInstance()!;
}

extension IsarLinksParsing on IsarLinks {
  Future<void> saveWithTrnx() async {
    await _isar.writeTxn(() => save());
  }
}
