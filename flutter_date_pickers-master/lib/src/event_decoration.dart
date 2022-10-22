import 'package:flutter/widgets.dart';

import 'day_picker.dart';
import 'range_picker.dart';
import 'week_picker.dart';


/// Signature for function which is used to set set specific decoration for
/// some days in [DayPicker], [WeekPicker] and [RangePicker].
///
/// See also:
/// * [DayPicker.eventDecorationBuilder]
/// * [WeekPicker.eventDecorationBuilder]
/// * [RangePicker.eventDecorationBuilder]
typedef EventDecorationBuilder = EventDecoration? Function(DateTime date);


/// Class to store styles for event (specific day in the date picker).
@immutable
class EventDecoration {

  /// Cell decoration for the specific day in the date picker (event).
  final BoxDecoration? boxDecoration;

  /// Style for number of the specific day in the date picker (event).
  final TextStyle? textStyle;

  /// Creates decoration for special day.
  ///
  /// Used for [EventDecorationBuilder] function which is usually passed to
  /// [DayPicker.eventDecorationBuilder], [WeekPicker.eventDecorationBuilder]
  /// and [RangePicker.eventDecorationBuilder] to set specific decoration for
  /// some days.
  const EventDecoration({this.boxDecoration, this.textStyle});
}