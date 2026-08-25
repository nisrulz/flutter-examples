import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:expense_manager/services/shared_pref_service.dart';
import 'package:expense_manager/repositories/category_repo.dart';
import 'package:expense_manager/repositories/expense_repo.dart';
import 'package:expense_manager/repositories/income_repo.dart';
import 'package:expense_manager/repositories/tag_repo.dart';
import 'package:expense_manager/services/data_service.dart';
import 'package:expense_manager/services/transaction_service.dart';

final getIt = GetIt.instance;
late Isar kIsar;

const kAppName = 'expense_manager';

// shared preferences
const kDateRange = ["3m", "6m", "1y", "ytd", "5y", "10y"];
const prefHomeMonthCount = 'home_month_count';
const prefCurrency = 'currency';
const prefAppInit = 'pref_app_initialised';

// strings
String? kCurrency;

// repos
ExpenseRepo get kExpenseRepo => getIt.get<ExpenseRepo>();
CategoryRepo get kCategoryRepo => getIt.get<CategoryRepo>();
IncomeRepo get kIncomeRepo => getIt.get<IncomeRepo>();
TagRepo get kTagRepo => getIt.get<TagRepo>();

// services
TransactionService get kTransactionService => getIt.get<TransactionService>();
SharedPrefService get kSharedPrefService => SharedPrefService();
DataService get kDataService => getIt.get<DataService>();

List<({String symbol, String name})> currencies = [
  (symbol: '\$', name: "Dollar"),
  (symbol: '€', name: "Euro"),
  (symbol: '£', name: "British Pound Sterling"),
  (symbol: '¥', name: "Japanese Yen"),
  (symbol: 'CHF', name: "Swiss Franc"),
  (symbol: '¥', name: "Chinese Yuan"),
  (symbol: '₹', name: "Indian Rupee"),
  (symbol: 'R\$', name: "Brazilian Real"),
  (symbol: 'R', name: "South African Rand"),
  (symbol: '₽', name: "Russian Ruble"),
  (symbol: 'RM', name: "Malaysian Ringgit"),
  (symbol: 'S\$', name: "Singapore Dollar"),
  (symbol: 'kr', name: "Krona"),
  (symbol: '₩', name: "South Korean Won"),
];

enum DataLoaderState { initiated, loading, loaded }
