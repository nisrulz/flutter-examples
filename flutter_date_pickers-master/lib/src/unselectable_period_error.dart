import 'date_period.dart';
import 'range_picker.dart';
import 'week_picker.dart';


/// Exception thrown when selected period contains custom disabled days.
class UnselectablePeriodException implements Exception {
  /// Dates inside selected period what can't be selected
  /// according custom rules.
  final List<DateTime> customDisabledDates;

  /// Selected period wanted by the user.
  final DatePeriod period;

  /// Creates exception that stores dates that can not be selected.
  ///
  /// See also:
  /// *[WeekPicker.onSelectionError]
  /// *[RangePicker.onSelectionError]
  UnselectablePeriodException(this.customDisabledDates, this.period);

  @override
  String toString() =>
        "UnselectablePeriodException:"
        " ${customDisabledDates.length} dates inside selected period "
        "(${period.start} - ${period.end}) "
        "can't be selected according custom rules (selectable pridicate). "
        "Check 'customDisabledDates' property "
        "to get entire list of such dates.";
}
