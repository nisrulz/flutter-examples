import 'package:expense_manager/misc/debouncer.dart';
import 'package:expense_manager/misc/utils.dart';
import 'package:expense_manager/constants.dart';
import 'package:expense_manager/models/transaction.dart';
import 'package:get/get.dart';

class TransactionsController extends GetxController {
  final transactions = <String, List<Transaction>>{};
  final debouncer = Debouncer(500);
  bool loading = false;
  bool dataLoaded = false;

  bool get showPlaceholder => transactions.isEmpty && dataLoaded;

  @override
  void onInit() {
    super.onInit();

    loadDataWithState(
      data: () => loadData(),
      onStateChange: (state) {
        loading = state == DataLoaderState.loading;
        dataLoaded = state == DataLoaderState.loaded;
        update();
      },
    );
  }

  Future<void> loadData() async {
    final List<Transaction> expenses = await kExpenseRepo.findAll();
    final List<Transaction> incomes = await kIncomeRepo.findAll();
    final combined = [expenses, incomes].expand((e) => e).toList();
    combined.sort((a, b) => b.date.compareTo(a.date));

    // group by year/month
    transactions.clear();
    for (var e in combined) {
      final key = friendlyDate(e.date, dateFormat: "MMMM yyyy");
      if (transactions[key] == null) {
        transactions[key] = [e];
      } else {
        transactions[key]!.add(e);
      }
    }

    update();
  }
}
