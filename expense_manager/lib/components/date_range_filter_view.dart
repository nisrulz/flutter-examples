import 'package:expense_manager/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateRangeFilterView extends StatelessWidget {
  final dates = <String>[].obs;
  final EdgeInsets? padding;
  final Function(String range) onDateSelected;

  DateRangeFilterView({
    super.key,
    this.padding,
    required this.onDateSelected,
  }) {
    dates.assignAll(kDateRange);
  }

  DateRangeFilterController get _controller =>
      Get.find<DateRangeFilterController>();

  @override
  Widget build(BuildContext context) {
    return GetX<DateRangeFilterController>(
        init: DateRangeFilterController(),
        builder: (controller) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: dates.map((e) {
              return InkWell(
                onTap: () {
                  controller.selectedRange.value = e;
                  onDateSelected(e);
                },
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    e.toUpperCase(),
                    style: TextStyle(color: getSelectedColor(e)),
                  ),
                ),
              );
            }).toList(),
          );
        });
  }

  Color? getSelectedColor(String range) {
    return _controller.selectedRange.value == range ? Colors.green : null;
  }
}

class DateRangeFilterController extends GetxController {
  final selectedRange = "1y".obs;
}
