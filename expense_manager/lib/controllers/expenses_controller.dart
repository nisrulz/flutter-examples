import 'package:expense_manager/constants.dart';
import 'package:expense_manager/controllers/base_controller.dart';
import 'package:expense_manager/misc/utils.dart';
import 'package:expense_manager/misc/extensions.dart';
import 'package:expense_manager/models/expense.dart';

abstract class ExpensesController extends BaseController {
  final transactions = <String, List<Expense>>{};
  bool loading = false;
  bool dataLoaded = false;

  int get totalCount => transactions.length;

  int get totalSum {
    return transactions.values.toList().fold(0, (previousValue, element) {
      return previousValue += element.sumAmounts();
    });
  }

  @override
  void onInit() {
    super.onInit();

    loadDataWithState(
      data: () => loadExpenses(),
      onStateChange: (state) {
        loading = state == DataLoaderState.loading;
        dataLoaded = state == DataLoaderState.loaded;
        update();
      },
    );
  }

  Future<List<Expense>> getExpenses();

  Future<void> loadExpenses() async {
    final expenses = await getExpenses();

    // group by year/month
    transactions.clear();
    for (var e in expenses) {
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
