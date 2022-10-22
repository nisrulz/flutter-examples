import 'range_picker.dart';
import 'unselectable_period_error.dart';
import 'week_picker.dart';


/// Signature for function that can be used to handle incorrect selections.
///
/// See also:
/// * [WeekPicker.onSelectionError]
/// * [RangePicker.onSelectionError]
typedef OnSelectionError = void Function(UnselectablePeriodException e);
