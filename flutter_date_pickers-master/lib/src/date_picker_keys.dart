import 'package:flutter/material.dart';

/// Keys for some date picker's widgets.
///
/// Useful for integration tests to find widgets.
class DatePickerKeys {
  /// Key for the previous page icon widget.
  final Key previousPageIconKey;

  /// Key for the next page icon widget.
  final Key nextPageIconKey;

  /// Key for showing month.
  final Key selectedPeriodKeys;

  ///
  DatePickerKeys(
      this.previousPageIconKey, this.nextPageIconKey, this.selectedPeriodKeys);
}
