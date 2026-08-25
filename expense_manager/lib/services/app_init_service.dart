import 'package:expense_manager/constants.dart';
import 'package:expense_manager/repositories/repo_factory.dart';
import 'package:expense_manager/repositories/service_factory.dart';
import 'package:flutter/material.dart';

class AppInitService {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await RepoFactory.init();
    await ServiceFactory.init();

    kCurrency = await kSharedPrefService.getString(prefCurrency) ?? '\$';

    // app initialisation
    await kDataService.initialiseAppValues();
  }
}
