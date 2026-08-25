import 'package:expense_manager/constants.dart';
import 'package:expense_manager/services/data_service.dart';
import 'package:expense_manager/services/transaction_service.dart';

class ServiceFactory {
  static Future<void> init() async {
    registerServices();
  }

  static registerServices() {
    getIt.registerLazySingleton(() => TransactionService());
    getIt.registerLazySingleton(() => DataService());
  }
}
