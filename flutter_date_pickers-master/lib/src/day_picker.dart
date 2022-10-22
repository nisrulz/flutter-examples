import 'package:flutter/material.dart';

import 'date_picker_keys.dart';
import 'date_picker_styles.dart';
import 'day_based_changable_picker.dart';
import 'day_picker_selection.dart';
import 'day_type.dart';
import 'event_decoration.dart';
import 'i_selectable_picker.dart';
import 'layout_settings.dart';

/// Date picker for selection one day.
class DayPicker<T extends Object> extends StatelessWidget {
  DayPicker._({Key? key,
    required this.onChanged,
    required this.firstDate,
    required this.lastDate,
    required this.selectionLogic,
    required this.selection,
    this.initiallyShowDate,
    this.datePickerLayoutSettings = const DatePickerLayoutSettings(),
    this.datePickerStyles,
    this.datePickerKeys,
    this.selectableDayPredicate,
    this.eventDecorationBuilder,
    this.onMonthChanged}) : super(key: key);

  /// Creates a day picker where only one single day can be selected.
  ///
  /// See also:
  /// * [DayPicker.multi] - day picker where many single days can be selected.
  static DayPicker<DateTime> single({
    Key? key,
    required DateTime selectedDate,
    required ValueChanged<DateTime> onChanged,
    required DateTime firstDate,
    required DateTime lastDate,
    DatePickerLayoutSettings datePickerLayoutSettings
      = const DatePickerLayoutSettings(),
    DateTime? initiallyShowDate,
    DatePickerRangeStyles? datePickerStyles,
    DatePickerKeys? datePickerKeys,
    SelectableDayPredicate? selectableDayPredicate,
    EventDecorationBuilder? eventDecorationBuilder,
    ValueChanged<DateTime>? onMonthChanged
  })
  {
    assert(!firstDate.isAfter(lastDate));
    assert(!lastDate.isBefore(firstDate));
    assert(!selectedDate.isBefore(firstDate));
    assert(!selectedDate.isAfter(lastDate));
    assert(initiallyShowDate == null
        || !initiallyShowDate.isAfter(lastDate));
    assert(initiallyShowDate == null
    || !initiallyShowDate.isBefore(firstDate));

    final selection = DayPickerSingleSelection(selectedDate);
    final selectionLogic = DaySelectable(
    selectedDate, firstDate, lastDate,
    selectableDayPredicate: selectableDayPredicate);

    return DayPicker<DateTime>._(
        onChanged: onChanged,
        firstDate: firstDate,
        lastDate: lastDate,
        initiallyShowDate: initiallyShowDate,
        selectionLogic: selectionLogic,
        selection: selection,
        eventDecorationBuilder: eventDecorationBuilder,
        onMonthChanged: onMonthChanged,
        selectableDayPredicate: selectableDayPredicate,
        datePickerKeys: datePickerKeys,
        datePickerStyles: datePickerStyles,
        datePickerLayoutSettings: datePickerLayoutSettings,
    );
  }


  /// Creates a day picker  where many single days can be selected.
  ///
  /// See also:
  /// * [DayPicker.single] - day picker where only one single day
  /// can be selected.
  static DayPicker<List<DateTime>> multi({Key? key,
    required List<DateTime> selectedDates,
    required ValueChanged<List<DateTime>> onChanged,
    required DateTime firstDate,
    required DateTime lastDate,
    DatePickerLayoutSettings datePickerLayoutSettings
      = const DatePickerLayoutSettings(),
    DateTime? initiallyShowDate,
    DatePickerRangeStyles? datePickerStyles,
    DatePickerKeys? datePickerKeys,
    SelectableDayPredicate? selectableDayPredicate,
    EventDecorationBuilder? eventDecorationBuilder,
    ValueChanged<DateTime>? onMonthChanged})
  {
    assert(!firstDate.isAfter(lastDate));
    assert(!lastDate.isBefore(firstDate));
    assert(initiallyShowDate == null
        || !initiallyShowDate.isAfter(lastDate));
    assert(initiallyShowDate == null
    || !initiallyShowDate.isBefore(lastDate));

    final selection =  DayPickerMultiSelection(selectedDates);
    final selectionLogic =  DayMultiSelectable(
        selectedDates, firstDate, lastDate,
        selectableDayPredicate: selectableDayPredicate);

    return DayPicker<List<DateTime>>._(
      onChanged: onChanged,
      firstDate: firstDate,
      lastDate: lastDate,
      initiallyShowDate: initiallyShowDate,
      selectionLogic: selectionLogic,
      selection: selection,
      eventDecorationBuilder: eventDecorationBuilder,
      onMonthChanged: onMonthChanged,
      selectableDayPredicate: selectableDayPredicate,
      datePickerKeys: datePickerKeys,
      datePickerStyles: datePickerStyles,
      datePickerLayoutSettings: datePickerLayoutSettings,
    );
  }

  /// The currently selected date.
  ///
  /// This date is highlighted in the picker.
  final DayPickerSelection selection;

  /// Called when the user picks a day.
  final ValueChanged<T> onChanged;

  /// The earliest date the user is permitted to pick.
  final DateTime firstDate;

  /// The latest date the user is permitted to pick.
  final DateTime lastDate;

  /// Date for defining what month should be shown initially.
  ///
  /// In case of null earliest of the [selection] will be shown.
  final DateTime? initiallyShowDate;

  /// Layout settings what can be customized by user
  final DatePickerLayoutSettings datePickerLayoutSettings;

  /// Styles what can be customized by user
  final DatePickerRangeStyles? datePickerStyles;

  /// Some keys useful for integration tests
  final DatePickerKeys? datePickerKeys;

  /// Function returns if day can be selected or not.
  ///
  /// If null
  final SelectableDayPredicate? selectableDayPredicate;

  /// Builder to get event decoration for each date.
  ///
  /// All event styles are overriden by selected styles
  /// except days with dayType is [DayType.notSelected].
  final EventDecorationBuilder? eventDecorationBuilder;

  // Called when the user changes the month.
  /// New DateTime object represents first day of new month and 00:00 time.
  final ValueChanged<DateTime>? onMonthChanged;

  /// Logic to handle user's selections.
  final ISelectablePicker<T> selectionLogic;
  
  @override
  // ignore: prefer_expression_function_bodies
  Widget build(BuildContext context) {
    return DayBasedChangeablePicker<T>(
      selectablePicker: selectionLogic,
      selection: selection,
      firstDate: firstDate,
      lastDate: lastDate,
      initiallyShownDate: initiallyShowDate,
      onChanged: onChanged,
      datePickerLayoutSettings: datePickerLayoutSettings,
      datePickerStyles: datePickerStyles ?? DatePickerRangeStyles(),
      datePickerKeys: datePickerKeys,
      eventDecorationBuilder: eventDecorationBuilder,
      onMonthChanged: onMonthChanged,
    );
  }
}