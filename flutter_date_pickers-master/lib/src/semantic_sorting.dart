import 'package:flutter/semantics.dart';

/// Defines semantic traversal order of the top-level widgets
/// inside the day or week picker.
class MonthPickerSortKey extends OrdinalSortKey {
  /// Previous month key.
  static const MonthPickerSortKey previousMonth = MonthPickerSortKey(1.0);

  /// Next month key.
  static const MonthPickerSortKey nextMonth = MonthPickerSortKey(2.0);

  /// Calendar key.
  static const MonthPickerSortKey calendar = MonthPickerSortKey(3.0);

  ///
  const MonthPickerSortKey(double order) : super(order);
}

/// Defines semantic traversal order of the top-level widgets
/// inside the month picker.
class YearPickerSortKey extends OrdinalSortKey {
  /// Previous year key.
  static const YearPickerSortKey previousYear = YearPickerSortKey(1.0);

  /// Next year key.
  static const YearPickerSortKey nextYear = YearPickerSortKey(2.0);

  /// Calendar key.
  static const YearPickerSortKey calendar = YearPickerSortKey(3.0);

  ///
  const YearPickerSortKey(double order) : super(order);
}
