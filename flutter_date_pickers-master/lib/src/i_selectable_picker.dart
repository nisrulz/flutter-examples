import 'dart:async';

import 'package:flutter/material.dart';

import 'date_period.dart';
import 'day_picker.dart' as day_picker;
import 'day_type.dart';
import 'range_picker.dart';
import 'unselectable_period_error.dart';
import 'utils.dart';

/// Interface for selection logic of the different date pickers.
///
/// T - is selection type.
abstract class ISelectablePicker<T> {
  /// The earliest date the user is permitted to pick.
  /// (only year, month and day matter, time doesn't matter)
  final DateTime firstDate;

  /// The latest date the user is permitted to pick.
  /// (only year, month and day matter, time doesn't matter)
  final DateTime lastDate;

  /// Function returns if day can be selected or not.
  final SelectableDayPredicate _selectableDayPredicate;

  /// StreamController for new selection (T).
  @protected
  StreamController<T> onUpdateController = StreamController<T>.broadcast();

  /// Stream with new selected (T) event.
  ///
  /// Throws [UnselectablePeriodException]
  /// if there is any custom disabled date in selected.
  Stream<T> get onUpdate => onUpdateController.stream;

  /// Constructor with required fields that used in non-abstract methods
  /// ([isDisabled]).
  ISelectablePicker(this.firstDate, this.lastDate,
      {SelectableDayPredicate? selectableDayPredicate})
      : _selectableDayPredicate =
            selectableDayPredicate ?? _defaultSelectableDayPredicate;

  /// If current selection exists and includes day/days that can't be selected
  /// according to the [_selectableDayPredicate]'
  bool get curSelectionIsCorrupted;

  /// Returns [DayType] for given [day].
  DayType getDayType(DateTime day);

  /// Call when user tap on the day cell.
  void onDayTapped(DateTime selectedDate);

  /// Returns if given day is disabled.
  ///
  /// Returns weather given day before the beginning of the [firstDate]
  /// or after the end of the [lastDate].
  ///
  /// If [_selectableDayPredicate] is set checks it as well.
  @protected
  bool isDisabled(DateTime day) {
    final DateTime beginOfTheFirstDay =
        DatePickerUtils.startOfTheDay(firstDate);
    final DateTime endOfTheLastDay = DatePickerUtils.endOfTheDay(lastDate);
    final bool customDisabled =
        _selectableDayPredicate != null ? !_selectableDayPredicate(day) : false;

    return day.isAfter(endOfTheLastDay) ||
        day.isBefore(beginOfTheFirstDay) ||
        customDisabled;
  }

  /// Closes [onUpdateController].
  /// After it [onUpdateController] can't get new events.
  void dispose() {
    onUpdateController.close();
  }

  static bool _defaultSelectableDayPredicate(_) => true;
}

/// Selection logic for WeekPicker.
class WeekSelectable extends ISelectablePicker<DatePeriod> {
  /// Initialized in ctor body.
  late DateTime _firstDayOfSelectedWeek;

  /// Initialized in ctor body.
  late DateTime _lastDayOfSelectedWeek;

  // It is int from 0 to 6 where 0 points to Sunday and 6 points to Saturday.
  // According to MaterialLocalization.firstDayOfWeekIndex.
  final int _firstDayOfWeekIndex;

  @override
  bool get curSelectionIsCorrupted => _checkCurSelection();

  /// Creates selection logic for WeekPicker.
  ///
  /// Entire week will be selected if
  /// * it is between [firstDate] and [lastDate]
  /// * it doesn't include unselectable days according to the
  ///   [selectableDayPredicate]
  ///
  /// If one or more days of the week are before [firstDate]
  /// first selection date will be the same as [firstDate].
  ///
  /// If one or more days of the week are after [lastDate]
  /// last selection date will be the same as [lastDate].
  ///
  /// If one or more days of week are not selectable according to the
  /// [selectableDayPredicate] nothing will be returned as selection
  /// but [UnselectablePeriodException] will be thrown.
  WeekSelectable(DateTime selectedDate, this._firstDayOfWeekIndex,
      DateTime firstDate, DateTime lastDate,
      {SelectableDayPredicate? selectableDayPredicate})
      : super(firstDate, lastDate,
            selectableDayPredicate: selectableDayPredicate) {
    DatePeriod selectedWeek = _getNewSelectedPeriod(selectedDate);
    _firstDayOfSelectedWeek = selectedWeek.start;
    _lastDayOfSelectedWeek = selectedWeek.end;
    _checkCurSelection();
  }

  @override
  DayType getDayType(DateTime date) {
    DayType result;

    DatePeriod selectedPeriod =
        DatePeriod(_firstDayOfSelectedWeek, _lastDayOfSelectedWeek);
    bool selectedPeriodIsBroken =
        _disabledDatesInPeriod(selectedPeriod).isNotEmpty;

    if (isDisabled(date)) {
      result = DayType.disabled;
    } else if (_isDaySelected(date) && !selectedPeriodIsBroken) {
      DateTime firstNotDisabledDayOfSelectedWeek =
          _firstDayOfSelectedWeek.isBefore(firstDate)
              ? firstDate
              : _firstDayOfSelectedWeek;

      DateTime lastNotDisabledDayOfSelectedWeek =
          _lastDayOfSelectedWeek.isAfter(lastDate)
              ? lastDate
              : _lastDayOfSelectedWeek;

      if (DatePickerUtils.sameDate(date, firstNotDisabledDayOfSelectedWeek) &&
          DatePickerUtils.sameDate(date, lastNotDisabledDayOfSelectedWeek)) {
        result = DayType.single;
      } else if (DatePickerUtils.sameDate(date, _firstDayOfSelectedWeek) ||
          DatePickerUtils.sameDate(date, firstDate)) {
        result = DayType.start;
      } else if (DatePickerUtils.sameDate(date, _lastDayOfSelectedWeek) ||
          DatePickerUtils.sameDate(date, lastDate)) {
        result = DayType.end;
      } else {
        result = DayType.middle;
      }
    } else {
      result = DayType.notSelected;
    }

    return result;
  }

  @override
  void onDayTapped(DateTime selectedDate) {
    DatePeriod newPeriod = _getNewSelectedPeriod(selectedDate);
    List<DateTime> customDisabledDays = _disabledDatesInPeriod(newPeriod);

    customDisabledDays.isEmpty
        ? onUpdateController.add(newPeriod)
        : onUpdateController.addError(
            UnselectablePeriodException(customDisabledDays, newPeriod));
  }

  // Returns new selected period according to tapped date.
  // Doesn't check custom disabled days.
  // You have to check it separately if it needs.
  DatePeriod _getNewSelectedPeriod(DateTime tappedDay) {
    DatePeriod newPeriod;

    DateTime firstDayOfTappedWeek =
        DatePickerUtils.getFirstDayOfWeek(tappedDay, _firstDayOfWeekIndex);
    DateTime lastDayOfTappedWeek =
        DatePickerUtils.getLastDayOfWeek(tappedDay, _firstDayOfWeekIndex);

    DateTime firstNotDisabledDayOfSelectedWeek =
        firstDayOfTappedWeek.isBefore(firstDate)
            ? firstDate
            : firstDayOfTappedWeek;

    DateTime lastNotDisabledDayOfSelectedWeek =
        lastDayOfTappedWeek.isAfter(lastDate) ? lastDate : lastDayOfTappedWeek;

    newPeriod = DatePeriod(
        firstNotDisabledDayOfSelectedWeek, lastNotDisabledDayOfSelectedWeek);
    return newPeriod;
  }

  bool _isDaySelected(DateTime date) {
    DateTime startOfTheStartDay =
        DatePickerUtils.startOfTheDay(_firstDayOfSelectedWeek);
    DateTime endOfTheLastDay =
        DatePickerUtils.endOfTheDay(_lastDayOfSelectedWeek);
    return !(date.isBefore(startOfTheStartDay) ||
        date.isAfter(endOfTheLastDay));
  }

  List<DateTime> _disabledDatesInPeriod(DatePeriod period) {
    List<DateTime> result = <DateTime>[];

    var date = period.start;

    while (!date.isAfter(period.end)) {
      if (isDisabled(date)) result.add(date);

      date = date.add(Duration(days: 1));
    }

    return result;
  }

  // Returns if current selection contains disabled dates.
  // Returns false if there is no any selection.
  bool _checkCurSelection() {
    bool noSelection =
        _firstDayOfSelectedWeek == null || _lastDayOfSelectedWeek == null;

    if (noSelection) return false;

    DatePeriod selectedPeriod =
        DatePeriod(_firstDayOfSelectedWeek, _lastDayOfSelectedWeek);
    List<DateTime> disabledDates = _disabledDatesInPeriod(selectedPeriod);

    bool selectedPeriodIsBroken = disabledDates.isNotEmpty;
    return selectedPeriodIsBroken;
  }
}

/// Selection logic for [day_picker.DayPicker].
class DaySelectable extends ISelectablePicker<DateTime> {
  /// Currently selected date.
  DateTime selectedDate;

  @override
  bool get curSelectionIsCorrupted => _checkCurSelection();

  /// Creates selection logic for [day_picker.DayPicker].
  ///
  /// Every day can be selected if it is between [firstDate] and [lastDate]
  /// and not unselectable according to the [selectableDayPredicate].
  ///
  /// If day is not selectable according to the [selectableDayPredicate]
  /// nothing will be returned as selection
  /// but [UnselectablePeriodException] will be thrown.
  DaySelectable(this.selectedDate, DateTime firstDate, DateTime lastDate,
      {SelectableDayPredicate? selectableDayPredicate})
      : super(firstDate, lastDate,
            selectableDayPredicate: selectableDayPredicate);

  @override
  DayType getDayType(DateTime date) {
    DayType result;

    if (isDisabled(date)) {
      result = DayType.disabled;
    } else if (_isDaySelected(date)) {
      result = DayType.single;
    } else {
      result = DayType.notSelected;
    }

    return result;
  }

  @override
  void onDayTapped(DateTime selectedDate) {
    DateTime newSelected = DatePickerUtils.sameDate(firstDate, selectedDate)
        ? selectedDate
        : DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
    onUpdateController.add(newSelected);
  }

  bool _isDaySelected(DateTime date) =>
      DatePickerUtils.sameDate(date, selectedDate);

  // Returns if current selection is disabled
  // according to the [_selectableDayPredicate].
  //
  // Returns false if there is no any selection.
  bool _checkCurSelection() {
    if (selectedDate == null) return false;
    bool selectedIsBroken = _selectableDayPredicate(selectedDate);

    return selectedIsBroken;
  }
}

/// Selection logic for [day_picker.DayPicker] where many single days can be
/// selected.
class DayMultiSelectable extends ISelectablePicker<List<DateTime>> {
  /// Currently selected dates.
  List<DateTime> selectedDates;

  /// Creates selection logic for [day_picker.DayPicker].
  ///
  /// Every day can be selected if it is between [firstDate] and [lastDate]
  /// and not unselectable according to the [selectableDayPredicate].
  ///
  /// If day is not selectable according to the [selectableDayPredicate]
  /// nothing will be returned as selection
  /// but [UnselectablePeriodException] will be thrown.
  DayMultiSelectable(this.selectedDates, DateTime firstDate, DateTime lastDate,
      {SelectableDayPredicate? selectableDayPredicate})
      : super(firstDate, lastDate,
            selectableDayPredicate: selectableDayPredicate);

  @override
  bool get curSelectionIsCorrupted => _checkCurSelection();

  @override
  DayType getDayType(DateTime date) {
    DayType result;

    if (isDisabled(date)) {
      result = DayType.disabled;
    } else if (_isDaySelected(date)) {
      result = DayType.single;
    } else {
      result = DayType.notSelected;
    }

    return result;
  }

  @override
  void onDayTapped(DateTime selectedDate) {
    bool alreadyExist =
        selectedDates.any((d) => DatePickerUtils.sameDate(d, selectedDate));

    if (alreadyExist) {
      List<DateTime> newSelectedDates = List.from(selectedDates)
        ..removeWhere((d) => DatePickerUtils.sameDate(d, selectedDate));

      onUpdateController.add(newSelectedDates);
    } else {
      DateTime newSelected = DatePickerUtils.sameDate(firstDate, selectedDate)
          ? selectedDate
          : DateTime(selectedDate.year, selectedDate.month, selectedDate.day);

      List<DateTime> newSelectedDates = List.from(selectedDates)
        ..add(newSelected);

      onUpdateController.add(newSelectedDates);
    }
  }

  bool _isDaySelected(DateTime date) =>
      selectedDates.any((d) => DatePickerUtils.sameDate(date, d));

  // Returns if current selection is disabled
  // according to the [_selectableDayPredicate].
  //
  // Returns false if there is no any selection.
  bool _checkCurSelection() {
    if (selectedDates == null || selectedDates.isEmpty) return false;
    bool selectedIsBroken = selectedDates.every(_selectableDayPredicate);

    return selectedIsBroken;
  }
}

/// Selection logic for [RangePicker].
class RangeSelectable extends ISelectablePicker<DatePeriod> {
  /// Initially selected period.
  DatePeriod selectedPeriod;

  @override
  bool get curSelectionIsCorrupted => _checkCurSelection();

  /// Creates selection logic for [RangePicker].
  ///
  /// Period can be selected if
  /// * it is between [firstDate] and [lastDate]
  /// * it doesn't include unselectable days according to the
  ///   [selectableDayPredicate]
  ///
  ///
  /// If one or more days of the period are not selectable according to the
  /// [selectableDayPredicate] nothing will be returned as selection
  /// but [UnselectablePeriodException] will be thrown.
  RangeSelectable(this.selectedPeriod, DateTime firstDate, DateTime lastDate,
      {SelectableDayPredicate? selectableDayPredicate})
      : super(firstDate, lastDate,
            selectableDayPredicate: selectableDayPredicate);

  @override
  DayType getDayType(DateTime date) {
    DayType result;

    bool selectedPeriodIsBroken =
        _disabledDatesInPeriod(selectedPeriod).isNotEmpty;

    if (isDisabled(date)) {
      result = DayType.disabled;
    } else if (_isDaySelected(date) && !selectedPeriodIsBroken) {
      if (DatePickerUtils.sameDate(date, selectedPeriod.start) &&
          DatePickerUtils.sameDate(date, selectedPeriod.end)) {
        result = DayType.single;
      } else if (DatePickerUtils.sameDate(date, selectedPeriod.start) ||
          DatePickerUtils.sameDate(date, firstDate)) {
        result = DayType.start;
      } else if (DatePickerUtils.sameDate(date, selectedPeriod.end) ||
          DatePickerUtils.sameDate(date, lastDate)) {
        result = DayType.end;
      } else {
        result = DayType.middle;
      }
    } else {
      result = DayType.notSelected;
    }

    return result;
  }

  @override
  void onDayTapped(DateTime selectedDate) {
    DatePeriod newPeriod = _getNewSelectedPeriod(selectedDate);
    List<DateTime> customDisabledDays = _disabledDatesInPeriod(newPeriod);

    customDisabledDays.isEmpty
        ? onUpdateController.add(newPeriod)
        : onUpdateController.addError(
            UnselectablePeriodException(customDisabledDays, newPeriod));
  }

  // Returns new selected period according to tapped date.
  DatePeriod _getNewSelectedPeriod(DateTime tappedDate) {
    // check if was selected only one date and we should generate period
    bool sameDate =
        DatePickerUtils.sameDate(selectedPeriod.start, selectedPeriod.end);
    DatePeriod newPeriod;

    // Was selected one-day-period.
    // With new user tap will be generated 2 dates as a period.
    if (sameDate) {
      // if user tap on the already selected single day
      bool selectedAlreadySelectedDay =
          DatePickerUtils.sameDate(tappedDate, selectedPeriod.end);
      bool isSelectedFirstDay = DatePickerUtils.sameDate(tappedDate, firstDate);
      bool isSelectedLastDay = DatePickerUtils.sameDate(tappedDate, lastDate);

      if (selectedAlreadySelectedDay) {
        if (isSelectedFirstDay && isSelectedLastDay) {
          newPeriod = DatePeriod(firstDate, lastDate);
        } else if (isSelectedFirstDay) {
          newPeriod =
              DatePeriod(firstDate, DatePickerUtils.endOfTheDay(firstDate));
        } else if (isSelectedLastDay) {
          newPeriod =
              DatePeriod(DatePickerUtils.startOfTheDay(lastDate), lastDate);
        } else {
          newPeriod = DatePeriod(DatePickerUtils.startOfTheDay(tappedDate),
              DatePickerUtils.endOfTheDay(tappedDate));
        }
      } else {
        DateTime startOfTheSelectedDay =
            DatePickerUtils.startOfTheDay(selectedPeriod.start);

        if (!tappedDate.isAfter(startOfTheSelectedDay)) {
          newPeriod = DatePickerUtils.sameDate(tappedDate, firstDate)
              ? DatePeriod(firstDate, selectedPeriod.end)
              : DatePeriod(DatePickerUtils.startOfTheDay(tappedDate),
                  selectedPeriod.end);
        } else {
          newPeriod = DatePickerUtils.sameDate(tappedDate, lastDate)
              ? DatePeriod(selectedPeriod.start, lastDate)
              : DatePeriod(selectedPeriod.start,
                  DatePickerUtils.endOfTheDay(tappedDate));
        }
      }

      // Was selected 2 dates as a period.
      // With new user tap new one-day-period will be generated.
    } else {
      bool sameAsFirst = DatePickerUtils.sameDate(tappedDate, firstDate);
      bool sameAsLast = DatePickerUtils.sameDate(tappedDate, lastDate);

      if (sameAsFirst && sameAsLast) {
        newPeriod = DatePeriod(firstDate, lastDate);
      } else if (sameAsFirst) {
        newPeriod =
            DatePeriod(firstDate, DatePickerUtils.endOfTheDay(firstDate));
      } else if (sameAsLast) {
        newPeriod =
            DatePeriod(DatePickerUtils.startOfTheDay(tappedDate), lastDate);
      } else {
        newPeriod = DatePeriod(DatePickerUtils.startOfTheDay(tappedDate),
            DatePickerUtils.endOfTheDay(tappedDate));
      }
    }

    return newPeriod;
  }

  // Returns if current selection contains disabled dates.
  // Returns false if there is no any selection.
  bool _checkCurSelection() {
    if (selectedPeriod == null) return false;
    List<DateTime> disabledDates = _disabledDatesInPeriod(selectedPeriod);

    bool selectedPeriodIsBroken = disabledDates.isNotEmpty;
    return selectedPeriodIsBroken;
  }

  List<DateTime> _disabledDatesInPeriod(DatePeriod period) {
    List<DateTime> result = <DateTime>[];

    var date = period.start;

    while (!date.isAfter(period.end)) {
      if (isDisabled(date)) result.add(date);

      date = date.add(Duration(days: 1));
    }

    return result;
  }

  bool _isDaySelected(DateTime date) {
    DateTime startOfTheStartDay =
        DatePickerUtils.startOfTheDay(selectedPeriod.start);
    DateTime endOfTheLastDay = DatePickerUtils.endOfTheDay(selectedPeriod.end);
    return !(date.isBefore(startOfTheStartDay) ||
        date.isAfter(endOfTheLastDay));
  }
}
