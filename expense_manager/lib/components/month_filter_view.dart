import 'package:expense_manager/misc/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MonthFilterView extends StatelessWidget {
  final dates = <DateTime>[].obs;
  final EdgeInsets? padding;
  final Function(DateTime dt) onDateSelected;

  MonthFilterView({
    super.key,
    this.padding,
    required this.onDateSelected,
  }) {
    final now = DateTime.now();
    dates.assignAll([
      now,
      now.lastMonth(numOfMonth: 1),
      now.lastMonth(numOfMonth: 2),
      now.lastMonth(numOfMonth: 3),
      now.lastMonth(numOfMonth: 4),
      now.lastMonth(numOfMonth: 5),
    ]);
  }

  MonthFilterController get _controller => Get.find<MonthFilterController>();

  @override
  Widget build(BuildContext context) {
    return GetX<MonthFilterController>(
        init: MonthFilterController(),
        builder: (controller) {
          return Padding(
            padding: padding ?? EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: dates.map((e) {
                return InkWell(
                  onTap: () {
                    controller.selectedMonth.value = e;
                    onDateSelected(e);
                  },
                  child: Text(
                    e.format('MMM'),
                    style: TextStyle(color: getSelectedColor(e)),
                  ),
                );
              }).toList(),
            ),
          );
        });
  }

  Color? getSelectedColor(DateTime e) {
    return _controller.selectedMonth.value.isSameMonthAs(e) == true
        ? Colors.green
        : null;
  }
}

class MonthFilterController extends GetxController {
  final selectedMonth = DateTime.now().obs;
}
