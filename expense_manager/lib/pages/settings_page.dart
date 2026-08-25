import 'package:expense_manager/constants.dart';
import 'package:expense_manager/controllers/settings_controller.dart';
import 'package:expense_manager/components/misc/custom_scaffold.dart';
import 'package:expense_manager/misc/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'categories_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  SettingsController get _controller => Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Settings',
      body: GetX<SettingsController>(
          init: SettingsController(),
          builder: (controller) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Icon(Icons.list),
                    title: Text('Categories'),
                    onTap: () => gotoPage(context, CategoriesPage()),
                  ),
                  ListTile(
                    leading: Icon(Icons.home),
                    title:
                        Text("Home page months (${controller.homeMonthCount})"),
                    onTap: () => _showHomePageMonthPicker(context),
                  ),
                  ListTile(
                    leading: Icon(Icons.currency_exchange),
                    title: Text("Currency (${controller.currency})"),
                    onTap: () => _showCurrencyPicker(context),
                  ),
                  ListTile(
                    leading: Icon(Icons.data_array),
                    title: Text('Load sample data'),
                    onTap: () async {
                      await controller.loadTestingData();
                    },
                    trailing: controller.loadingTestData.value
                        ? CircularProgressIndicator()
                        : null,
                  ),
                  ListTile(
                    leading: Icon(Icons.clear),
                    title: Text('Clear data'),
                    onTap: () async {
                      await controller.clearData();
                    },
                    trailing: controller.loadingTestData.value
                        ? CircularProgressIndicator()
                        : null,
                  ),
                ],
              ),
            );
          }),
    );
  }

  void _showHomePageMonthPicker(BuildContext context) {
    final numbers = [1, 2, 3, 4, 5, 6];
    showCupertinoModal(
      context,
      initialItem: numbers.indexOf(_controller.homeMonthCount.value),
      onSelectedItemChanged: (value) {
        _controller.setHomeMonthCount(numbers[value]);
      },
      children: numbers.map((e) {
        return Text(e.toString());
      }).toList(),
    );
  }

  void _showCurrencyPicker(BuildContext context) {
    showCupertinoModal(
      context,
      initialItem: _controller.currencyIndex,
      itemExtent: 50,
      height: 300,
      onSelectedItemChanged: (value) {
        _controller.setCurrency(currencies[value].symbol);
      },
      children: currencies.map((e) {
        return Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text("${e.name} - ${e.symbol}"),
        );
      }).toList(),
    );
  }
}
