import 'package:flutter_date_pickers/src/day_type.dart';
import 'package:flutter_date_pickers/src/i_selectable_picker.dart';
import 'package:flutter_test/flutter_test.dart';

import 'date_time_utils.dart';

void main() {
  group("DaySelectable test.", () {
    test("getDayType() returns correct type for different dates", () {
      final selectedDate = DateTime.now();
      final firstDate = selectedDate.subtract(const Duration(days: 10));
      final lastDate = selectedDate.add(const Duration(days: 10));
      final disabledDate = selectedDate.subtract(const Duration(days: 1));

      // ignore: prefer_function_declarations_over_variables
      final selectablePredicate = (DateTime d)
        => !DateTimeUtils.sameDate(d, disabledDate);

      final selectableLogic = DaySelectable(
          selectedDate, firstDate, lastDate,
          selectableDayPredicate: selectablePredicate);
      final selectedDateType = selectableLogic.getDayType(selectedDate);
      final notSelectedEnabledDateType = selectableLogic.getDayType(firstDate);
      final disabledDateType = selectableLogic.getDayType(disabledDate);

      expect(selectedDateType, DayType.single);
      expect(notSelectedEnabledDateType, DayType.notSelected);
      expect(disabledDateType, DayType.disabled);
    });
  });
}