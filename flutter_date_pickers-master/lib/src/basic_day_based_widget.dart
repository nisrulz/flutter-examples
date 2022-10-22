import 'package:flutter/material.dart';

import 'date_picker_mixin.dart';
import 'date_picker_styles.dart';
import 'day_type.dart';
import 'event_decoration.dart';
import 'i_selectable_picker.dart';
import 'layout_settings.dart';
import 'utils.dart';

/// Widget for date pickers based on days and cover entire month.
/// Each cell of this picker is day.
class DayBasedPicker<T> extends StatelessWidget with CommonDatePickerFunctions {
  /// Selection logic.
  final ISelectablePicker selectablePicker;

  /// The current date at the time the picker is displayed.
  final DateTime currentDate;

  /// The earliest date the user is permitted to pick.
  /// (only year, month and day matter, time doesn't matter)
  final DateTime firstDate;

  /// The latest date the user is permitted to pick.
  /// (only year, month and day matter, time doesn't matter)
  final DateTime lastDate;

  /// The month whose days are displayed by this picker.
  final DateTime displayedMonth;

  /// Layout settings what can be customized by user
  final DatePickerLayoutSettings datePickerLayoutSettings;

  ///  Key fo selected month (useful for integration tests)
  final Key? selectedPeriodKey;

  /// Styles what can be customized by user
  final DatePickerRangeStyles datePickerStyles;

  /// Builder to get event decoration for each date.
  ///
  /// All event styles are overridden by selected styles
  /// except days with dayType is [DayType.notSelected].
  final EventDecorationBuilder? eventDecorationBuilder;

  /// Localizations used to get strings for prev/next button tooltips,
  /// weekday headers and display values for days numbers.
  final MaterialLocalizations localizations;

  /// Creates main date picker view where every cell is day.
  DayBasedPicker(
      {Key? key,
      required this.currentDate,
      required this.firstDate,
      required this.lastDate,
      required this.displayedMonth,
      required this.datePickerLayoutSettings,
      required this.datePickerStyles,
      required this.selectablePicker,
      required this.localizations,
      this.selectedPeriodKey,
      this.eventDecorationBuilder})
      : assert(!firstDate.isAfter(lastDate)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> labels = <Widget>[];

    List<Widget> headers = _buildHeaders(localizations);
    List<Widget> daysBeforeMonthStart = _buildCellsBeforeStart(localizations);
    List<Widget> monthDays = _buildMonthCells(localizations);
    List<Widget> daysAfterMonthEnd = _buildCellsAfterEnd(localizations);

    labels.addAll(headers);
    labels.addAll(daysBeforeMonthStart);
    labels.addAll(monthDays);
    labels.addAll(daysAfterMonthEnd);

    return Padding(
      padding: datePickerLayoutSettings.contentPadding,
      child: Column(
        children: <Widget>[
          Flexible(
            child: GridView.custom(
              physics: datePickerLayoutSettings.scrollPhysics,
              gridDelegate: datePickerLayoutSettings.dayPickerGridDelegate,
              childrenDelegate:
                  SliverChildListDelegate(labels, addRepaintBoundaries: false),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildHeaders(MaterialLocalizations localizations) {
    final int firstDayOfWeekIndex = datePickerStyles.firstDayOfeWeekIndex ??
        localizations.firstDayOfWeekIndex;

    DayHeaderStyleBuilder dayHeaderStyleBuilder =
        datePickerStyles.dayHeaderStyleBuilder ??
            // ignore: avoid_types_on_closure_parameters
            (int i) => datePickerStyles.dayHeaderStyle;

    List<Widget> headers = getDayHeaders(dayHeaderStyleBuilder,
        localizations.narrowWeekdays, firstDayOfWeekIndex);

    return headers;
  }

  List<Widget> _buildCellsBeforeStart(MaterialLocalizations localizations) {
    List<Widget> result = [];

    final int year = displayedMonth.year;
    final int month = displayedMonth.month;
    final int firstDayOfWeekIndex = datePickerStyles.firstDayOfeWeekIndex ??
        localizations.firstDayOfWeekIndex;
    final int firstDayOffset =
        computeFirstDayOffset(year, month, firstDayOfWeekIndex);

    final bool showDates = datePickerLayoutSettings.showPrevMonthEnd;
    if (showDates) {
      int prevMonth = month - 1;
      if (prevMonth < 1) prevMonth = 12;
      int prevYear = prevMonth == 12 ? year - 1 : year;

      int daysInPrevMonth = DatePickerUtils.getDaysInMonth(prevYear, prevMonth);
      List<Widget> days = List.generate(firstDayOffset, (index) => index)
          .reversed
          .map((i) => daysInPrevMonth - i)
          .map((day) => _buildCell(prevYear, prevMonth, day))
          .toList();

      result = days;
    } else {
      result = List.generate(firstDayOffset, (_) => const SizedBox.shrink());
    }

    return result;
  }

  List<Widget> _buildMonthCells(MaterialLocalizations localizations) {
    List<Widget> result = [];

    final int year = displayedMonth.year;
    final int month = displayedMonth.month;
    final int daysInMonth = DatePickerUtils.getDaysInMonth(year, month);

    for (int i = 1; i <= daysInMonth; i += 1) {
      Widget dayWidget = _buildCell(year, month, i);
      result.add(dayWidget);
    }

    return result;
  }

  List<Widget> _buildCellsAfterEnd(MaterialLocalizations localizations) {
    List<Widget> result = [];
    final bool showDates = datePickerLayoutSettings.showNextMonthStart;
    if (!showDates) return result;

    final int year = displayedMonth.year;
    final int month = displayedMonth.month;
    final int firstDayOfWeekIndex = datePickerStyles.firstDayOfeWeekIndex ??
        localizations.firstDayOfWeekIndex;
    final int firstDayOffset =
        computeFirstDayOffset(year, month, firstDayOfWeekIndex);
    final int daysInMonth = DatePickerUtils.getDaysInMonth(year, month);
    final int totalFilledDays = firstDayOffset + daysInMonth;

    int reminder = totalFilledDays % 7;
    if (reminder == 0) return result;
    final int emptyCellsNum = 7 - reminder;

    int nextMonth = month + 1;
    result = List.generate(emptyCellsNum, (i) => i + 1)
        .map((day) => _buildCell(year, nextMonth, day))
        .toList();

    return result;
  }

  Widget _buildCell(int year, int month, int day) {
    DateTime dayToBuild = DateTime(year, month, day);
    dayToBuild = _checkDateTime(dayToBuild);

    DayType dayType = selectablePicker.getDayType(dayToBuild);

    Widget dayWidget = _DayCell(
      day: dayToBuild,
      currentDate: currentDate,
      selectablePicker: selectablePicker,
      datePickerStyles: datePickerStyles,
      eventDecorationBuilder: eventDecorationBuilder,
      localizations: localizations,
    );

    if (dayType != DayType.disabled) {
      dayWidget = GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => selectablePicker.onDayTapped(dayToBuild),
        child: dayWidget,
      );
    }

    return dayWidget;
  }

  /// Checks if [DateTime] is same day as [lastDate] or [firstDate]
  /// and returns dt corrected (with time of [lastDate] or [firstDate]).
  DateTime _checkDateTime(DateTime dt) {
    DateTime result = dt;

    // If dayToBuild is the first day we need to save original time for it.
    if (DatePickerUtils.sameDate(dt, firstDate)) result = firstDate;

    // If dayToBuild is the last day we need to save original time for it.
    if (DatePickerUtils.sameDate(dt, lastDate)) result = lastDate;

    return result;
  }
}

class _DayCell extends StatelessWidget {
  /// Day for this cell.
  final DateTime day;

  /// Selection logic.
  final ISelectablePicker selectablePicker;

  /// Styles what can be customized by user
  final DatePickerRangeStyles datePickerStyles;

  /// The current date at the time the picker is displayed.
  final DateTime currentDate;

  /// Builder to get event decoration for each date.
  ///
  /// All event styles are overridden by selected styles
  /// except days with dayType is [DayType.notSelected].
  final EventDecorationBuilder? eventDecorationBuilder;

  final MaterialLocalizations localizations;

  const _DayCell(
      {Key? key,
      required this.day,
      required this.selectablePicker,
      required this.datePickerStyles,
      required this.currentDate,
      required this.localizations,
      this.eventDecorationBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DayType dayType = selectablePicker.getDayType(day);

    BoxDecoration? decoration;
    TextStyle? itemStyle;

    if (dayType != DayType.disabled && dayType != DayType.notSelected) {
      itemStyle = _getSelectedTextStyle(dayType);
      decoration = _getSelectedDecoration(dayType);
    } else if (dayType == DayType.disabled) {
      itemStyle = datePickerStyles.disabledDateStyle;
    } else if (DatePickerUtils.sameDate(currentDate, day)) {
      itemStyle = datePickerStyles.currentDateStyle;
    } else {
      itemStyle = datePickerStyles.defaultDateTextStyle;
    }

    // Merges decoration and textStyle with [EventDecoration].
    //
    // Merges only in cases if [dayType] is DayType.notSelected.
    // If day is current day it is also gets event decoration
    // instead of decoration for current date.
    if (dayType == DayType.notSelected && eventDecorationBuilder != null) {
      EventDecoration? eDecoration = eventDecorationBuilder != null
          ? eventDecorationBuilder!.call(day)
          : null;

      decoration = eDecoration?.boxDecoration ?? decoration;
      itemStyle = eDecoration?.textStyle ?? itemStyle;
    }

    String semanticLabel = '${localizations.formatDecimal(day.day)}, '
        '${localizations.formatFullDate(day)}';

    bool daySelected =
        dayType != DayType.disabled && dayType != DayType.notSelected;

    Widget dayWidget = Container(
      decoration: decoration,
      child: Center(
        child: Semantics(
          // We want the day of month to be spoken first irrespective of the
          // locale-specific preferences or TextDirection. This is because
          // an accessibility user is more likely to be interested in the
          // day of month before the rest of the date, as they are looking
          // for the day of month. To do that we prepend day of month to the
          // formatted full date.
          label: semanticLabel,
          selected: daySelected,
          child: ExcludeSemantics(
            child: Text(localizations.formatDecimal(day.day), style: itemStyle),
          ),
        ),
      ),
    );

    return dayWidget;
  }

  BoxDecoration? _getSelectedDecoration(DayType dayType) {
    BoxDecoration? result;

    if (dayType == DayType.single) {
      result = datePickerStyles.selectedSingleDateDecoration;
    } else if (dayType == DayType.start) {
      result = datePickerStyles.selectedPeriodStartDecoration;
    } else if (dayType == DayType.end) {
      result = datePickerStyles.selectedPeriodLastDecoration;
    } else {
      result = datePickerStyles.selectedPeriodMiddleDecoration;
    }

    return result;
  }

  TextStyle? _getSelectedTextStyle(DayType dayType) {
    TextStyle? result;

    if (dayType == DayType.single) {
      result = datePickerStyles.selectedDateStyle;
    } else if (dayType == DayType.start) {
      result = datePickerStyles.selectedPeriodStartTextStyle;
    } else if (dayType == DayType.end) {
      result = datePickerStyles.selectedPeriodEndTextStyle;
    } else {
      result = datePickerStyles.selectedPeriodMiddleTextStyle;
    }

    return result;
  }
}
