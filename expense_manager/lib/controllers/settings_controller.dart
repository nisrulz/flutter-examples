import 'package:expense_manager/constants.dart';
import 'package:expense_manager/services/data_service.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  final loadingTestData = false.obs;
  final homeMonthCount = 3.obs;
  final currency = '\$'.obs;

  int get currencyIndex {
    final result = currencies
        .firstWhereOrNull((element) => element.symbol == currency.value);
    return result == null ? 0 : currencies.indexOf(result);
  }

  @override
  void onInit() {
    super.onInit();
    loadDefaultValues();
  }

  Future<void> loadDefaultValues() async {
    homeMonthCount.value =
        await kSharedPrefService.getInt(prefHomeMonthCount) ?? 3;
    currency.value = await kSharedPrefService.getString(prefCurrency) ?? '\$';
  }

  setHomeMonthCount(int value) async {
    homeMonthCount.value = value;
    await kSharedPrefService.setInt(prefHomeMonthCount, value);
  }

  setCurrency(String value) async {
    currency.value = value;
    await kSharedPrefService.setString(prefCurrency, value);
    kCurrency = value;
  }

  Future<void> logout() async {
    await DataService().clearAll();
  }

  Future<void> loadTestingData() async {
    await DataService().loadTestingData();
  }

  Future<void> clearData() async {
    await kDataService.clearAll();
    update();
  }
}
