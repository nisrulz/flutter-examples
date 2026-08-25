import 'package:expense_manager/misc/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_page.dart';
import 'reports_page.dart';
import 'settings_page.dart';
import 'tags_page.dart';
import 'transactions_page.dart';

class MainPage extends StatelessWidget {
  final _pageIndex = 0.obs;

  MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _buildPage(_pageIndex.value)),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            onTap: (value) => _changePage(value),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: CustomColors.primary,
            currentIndex: _pageIndex.value,
            items: [
              BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
              BottomNavigationBarItem(
                  label: 'History', icon: Icon(Icons.list_alt_outlined)),
              BottomNavigationBarItem(
                  label: 'Tags', icon: Icon(Icons.local_offer)),
              BottomNavigationBarItem(
                  label: 'Statistics', icon: Icon(Icons.bar_chart)),
              BottomNavigationBarItem(
                  label: 'Settings', icon: Icon(Icons.settings)),
            ],
          )),
    );
  }

  Widget _buildPage(int pageIndex) {
    final pages = {
      0: HomePage(),
      1: TransactionsPage(),
      2: TagsPage(),
      3: ReportsPage(),
      4: SettingsPage(),
    };
    return pages[pageIndex] ?? HomePage();
  }

  void _changePage(int value) {
    _pageIndex.value = value;
  }
}
