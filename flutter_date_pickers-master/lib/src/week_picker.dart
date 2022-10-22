import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'date_period.dart';
import 'date_picker_keys.dart';
import 'date_picker_styles.dart';
import 'day_based_changable_picker.dart';
import 'day_picker_selection.dart';
import 'day_type.dart';
import 'event_decoration.dart';
import 'i_selectable_picker.dart';
import 'layout_settings.dart';
import 'typedefs.dart';

/// Date picker for selection a week.
class WeekPicker extends StatelessWidget {
  /// Creates a month picker.
  WeekPicker(
      {Key? key,
      required this.selectedDate,
      required this.onChanged,
      required this.firstDate,
      required this.lastDate,
      this.initiallyShowDate,
      this.datePickerLayoutSettings = const DatePickerLayoutSettings(),
      this.datePickerStyles,
      this.datePickerKeys,
      this.selectableDayPredicate,
      this.onSelectionError,
      this.eventDecorationBuilder,
      this.onMonthChanged})
      : assert(!firstDate.isAfter(lastDate)),
        assert(!lastDate.isBefore(firstDate)),
        assert(!selectedDate.isBefore(firstDate)),
        assert(!selectedDate.isAfter(lastDate)),
        assert(initiallyShowDate == null
            || !initiallyShowDate.isAfter(lastDate)),
        assert(initiallyShowDate == null
            || !initiallyShowDate.isBefore(firstDate)),
        super(key: key);

  /// The currently selected date.
  ///
  /// This date is highlighted in the picker.
  final DateTime selectedDate;

  /// Called when the user picks a week.
  final ValueChanged<DatePeriod> onChanged;

  /// Called when the error was thrown after user selection.
  /// (e.g. when user selected a week with one or more days
  /// what can't be selected)
  final OnSelectionError? onSelectionError;

  /// The earliest date the user is permitted to pick.
  final DateTime firstDate;

  /// The latest date the user is permitted to pick.
  final DateTime lastDate;

  /// Date for defining what month should be shown initially.
  ///
  /// In case of null month with earliest date of the selected week
  /// will be shown.
  final DateTime? initiallyShowDate;

  /// Layout settings what can be customized by user
  final DatePickerLayoutSettings datePickerLayoutSettings;

  /// Some keys useful for integration tests
  final DatePickerKeys? datePickerKeys;

  /// Styles what can be customized by user
  final DatePickerRangeStyles? datePickerStyles;

  /// Function returns if day can be selected or not.
  final SelectableDayPredicate? selectableDayPredicate;

  /// Builder to get event decoration for each date.
  ///
  /// All event styles are overriden by selected styles
  /// except days with dayType is [DayType.notSelected].
  final EventDecorationBuilder? eventDecorationBuilder;

  /// Called when the user changes the month.
  /// New DateTime object represents first day of new month and 00:00 time.
  final ValueChanged<DateTime>? onMonthChanged;

  @override
  Widget build(BuildContext context) {
    MaterialLocalizations localizations = MaterialLocalizations.of(context);

    int firstDayOfWeekIndex = datePickerStyles?.firstDayOfeWeekIndex ??
        localizations.firstDayOfWeekIndex;

    ISelectablePicker<DatePeriod> weekSelectablePicker = WeekSelectable(
        selectedDate, firstDayOfWeekIndex, firstDate, lastDate,
        selectableDayPredicate: selectableDayPredicate);

    return DayBasedChangeablePicker<DatePeriod>(
      selectablePicker: weekSelectablePicker,
      // todo: maybe create selection for week
      // todo: and change logic here to work with it
      selection: DayPickerSingleSelection(selectedDate),
      firstDate: firstDate,
      lastDate: lastDate,
      initiallyShownDate: initiallyShowDate,
      onChanged: onChanged,
      onSelectionError: onSelectionError,
      datePickerLayoutSettings: datePickerLayoutSettings,
      datePickerStyles: datePickerStyles ?? DatePickerRangeStyles(),
      datePickerKeys: datePickerKeys,
      eventDecorationBuilder: eventDecorationBuilder,
      onMonthChanged: onMonthChanged,
    );
  }
}
