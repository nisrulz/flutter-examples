import 'package:flutter_date_pickers/src/day_type.dart';
import 'package:flutter_date_pickers/src/i_selectable_picker.dart';
import 'package:flutter_test/flutter_test.dart';

import 'date_time_utils.dart';

void main() {
  group("DayMultiSelectable test.", () {
    test("getDayType() returns correct type for different dates", () {
      final now = DateTime.now();
      final selectedDates = [
        now.subtract(const Duration(days: 1)),
        now,
        now.add(const Duration(days: 1)),
      ];

      final firstDate = now.subtract(const Duration(days: 10));
      final lastDate = now.add(const Duration(days: 10));
      final disabledDate = now.subtract(const Duration(days: 5));

      // ignore: prefer_function_declarations_over_variables
      final selectablePredicate = (DateTime d)
      => !DateTimeUtils.sameDate(d, disabledDate);

      final selectableLogic = DayMultiSelectable(
          selectedDates, firstDate, lastDate,
          selectableDayPredicate: selectablePredicate);

      final notSelectedEnabledDateType = selectableLogic.getDayType(firstDate);
      expect(notSelectedEnabledDateType, DayType.notSelected);

      final disabledDateType = selectableLogic.getDayType(disabledDate);
      expect(disabledDateType, DayType.disabled);

      for (DateTime d in selectedDates) {
        final selectedDateType = selectableLogic.getDayType(d);
        expect(selectedDateType, DayType.single,
            reason: "Incorrect DayType for the date ${d.toString()}");
      }
    });
  });
}