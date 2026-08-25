import 'dart:math';
import 'package:expense_manager/misc/extensions.dart';
import 'package:expense_manager/misc/utils.dart';
import 'package:expense_manager/constants.dart';
import 'package:expense_manager/models/expense.dart';
import 'package:expense_manager/models/income.dart';
import 'package:expense_manager/models/transaction.dart';
import 'package:get/get.dart';

class MonthlyReportController extends GetxController {
  final List<MonthlySpotData<Expense>> expenseData = [];
  final List<MonthlySpotData<Income>> incomeData = [];
  final List<MonthlySpotData<Transaction>> earningsData = [];
  final _chartDisplayMap = <int, bool>{};
  final filter = _Filter(
    startDate: DateTime.now().lastMonth(numOfMonth: 5).startDate(),
    endDate: DateTime.now().endDate(),
  );
  ({int expense, int income, int earnings, int year, int month})? touchedData;

  double? yAxisInterval;
  double lowerBound = 0;
  double upperBound = 0;

  List<MonthlySpotData<Transaction>> get largerTransactionData {
    if (expenseData.isLargerThan(incomeData)) return expenseData;
    return incomeData;
  }

  List<MonthlySpotData<Transaction>> get smallerTransactionData {
    if (expenseData.isLargerThan(incomeData)) return incomeData;
    return expenseData;
  }

  DateTime get touchDataDate {
    if (touchedData == null) return DateTime.now();
    return DateTime.now().copyWith(
      year: touchedData?.year,
      month: touchedData?.month,
    );
  }

  bool get isLargeDataSet => largerTransactionData.length > 12;
  double get xAxisInterval =>
      earningsData.length <= 6 ? 1 : (earningsData.length / 6);

  @override
  void onInit() {
    super.onInit();
    loadChartData("1y").then((value) {
      // default to last month touched and show all data
      if (expenseData.isNotEmpty) {
        onChartTouched(expenseData.length - 1);
      }
      updateChartDisplay(1, true);
      updateChartDisplay(2, true);
      updateChartDisplay(3, true);
    });
  }

  Future<void> loadChartData(String range) async {
    // update filter
    filter.updateWithRange(range);

    await loadExpenses();
    await loadIncomes();
    padExpenseOrIncomeData();
    loadEarningsData();
    update();
  }

  Future<void> loadExpenses() async {
    final expenses =
        await kExpenseRepo.findByDateRange(filter.startDate, filter.endDate);
    if (expenses.isEmpty) {
      expenseData.clear();
      return;
    }

    expenseData.clear();

    var i = 0;
    MonthlySpotData<Expense>? spotData;
    for (var expense in expenses) {
      if (spotData == null || !spotData.isSameMonth(expense.date)) {
        spotData = MonthlySpotData<Expense>(
          id: i,
          year: expense.date.year,
          month: expense.date.month,
          totalAmountCents: expense.amountCents,
          transactions: [expense],
        );
        expenseData.add(spotData);
        i++;
      } else {
        spotData.increment(expense.amountCents);
        spotData.transactions.add(expense);
      }
    }
  }

  Future<void> loadIncomes() async {
    final incomes =
        await kIncomeRepo.findByDateRange(filter.startDate, filter.endDate);
    if (incomes.isEmpty) {
      incomeData.clear();
      return;
    }

    incomeData.clear();

    var i = 0;
    MonthlySpotData<Income>? spotData;
    for (var income in incomes) {
      if (spotData == null || !spotData.isSameMonth(income.date)) {
        spotData = MonthlySpotData<Income>(
          id: i,
          year: income.date.year,
          month: income.date.month,
          totalAmountCents: income.amountCents,
          transactions: [income],
        );
        incomeData.add(spotData);
        i++;
      } else {
        spotData.increment(income.amountCents);
        spotData.transactions.add(income);
      }
    }
  }

  void loadEarningsData() {
    earningsData.clear();

    num minValue = -1;
    num maxValue = -1;
    for (var i = 0; i < largerTransactionData.length; i++) {
      final expense = expenseData[i];
      final income = incomeData[i];
      final earningsAmount =
          max(0, income.totalAmountCents - expense.totalAmountCents);
      earningsData.add(MonthlySpotData<Transaction>(
        id: i,
        year: expense.year,
        month: expense.month,
        totalAmountCents: earningsAmount,
        transactions: [],
      ));

      // store min, max
      if (minValue.isNegative) {
        minValue = min(earningsAmount,
            min(expense.totalAmountCents, income.totalAmountCents));
      }
      minValue = min(
        minValue,
        min(earningsAmount,
            min(expense.totalAmountCents, income.totalAmountCents)),
      );
      maxValue = max(
        maxValue,
        max(earningsAmount,
            max(expense.totalAmountCents, income.totalAmountCents)),
      );
    }
    yAxisInterval =
        calculateChartInterval(minValue, maxValue, interval: 4) / 100;
    lowerBound = ((minValue / 1.1) / 100).roundToDouble();
    upperBound = ((maxValue / 100) + yAxisInterval!).toDouble();
  }

  // pad the smaller data list with dummy data so that both have the same size
  void padExpenseOrIncomeData() {
    if (expenseData.isSameSizeAs(incomeData)) return;

    final extraLength = (expenseData.length - incomeData.length).abs();
    final smallerInitialLength = smallerTransactionData.length;
    for (var i = 0; i < extraLength; i++) {
      final data = largerTransactionData[smallerInitialLength + i];
      if (expenseData.isLargerThan(incomeData)) {
        smallerTransactionData.add(MonthlySpotData<Income>(
          id: smallerInitialLength + i,
          year: data.year,
          month: data.month,
          totalAmountCents: 0,
          transactions: [],
        ));
      } else {
        smallerTransactionData.add(MonthlySpotData<Expense>(
          id: smallerInitialLength + i,
          year: data.year,
          month: data.month,
          totalAmountCents: 0,
          transactions: [],
        ));
      }
    }
  }

  void onChartTouched(int index) {
    touchedData = (
      expense: expenseData[index].totalAmountCents,
      income: incomeData[index].totalAmountCents,
      earnings: incomeData[index].totalAmountCents -
          expenseData[index].totalAmountCents,
      month: expenseData[index].month,
      year: expenseData[index].year,
    );
    update();
  }

  bool shouldDisplayInChart(int id) {
    return _chartDisplayMap[id] == true;
  }

  void updateChartDisplay(int id, bool checked) {
    if (checked) {
      _chartDisplayMap[id] = true;
    } else {
      _chartDisplayMap.remove(id);
    }
    update();
  }
}

class _Filter {
  DateTime? startDate;
  DateTime? endDate;

  _Filter({this.startDate, this.endDate});

  void updateWithRange(String range) {
    endDate = DateTime.now().endDate();
    switch (range) {
      case '3m':
        startDate = DateTime.now().lastMonth(numOfMonth: 2).startDate();
        break;
      case '6m':
        startDate = DateTime.now().lastMonth(numOfMonth: 5).startDate();
        break;
      case '1y':
        startDate = DateTime.now().lastMonth(numOfMonth: 11).startDate();
        break;
      case 'ytd':
        startDate = DateTime.now().copyWith(month: 1).startDate();
        break;
      case '5y':
        startDate = DateTime.now().lastMonth(numOfMonth: 5 * 11).startDate();
        break;
      case '10y':
        startDate = DateTime.now().lastMonth(numOfMonth: 10 * 11).startDate();
        break;
      default:
    }
  }
}

class MonthlySpotData<T> {
  final int id;
  final int year;
  final int month;
  int totalAmountCents;
  final List<T> transactions;

  MonthlySpotData({
    required this.id,
    required this.year,
    required this.month,
    required this.totalAmountCents,
    required this.transactions,
  });

  String get friendlyMonth {
    if (month == 0) return '';
    return DateTime.now().copyWith(month: month, day: 1).format('MMM');
  }

  String get friendlyMonthYear {
    if (month == 0) return '';
    return DateTime.now()
        .copyWith(month: month, year: year, day: 1)
        .format('M/yy');
  }

  bool isSameMonth(DateTime date) {
    return year == date.year && month == date.month;
  }

  void increment(int amount) {
    totalAmountCents = totalAmountCents + amount;
  }
}
