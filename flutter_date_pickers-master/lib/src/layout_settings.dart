import 'dart:math' as math;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'day_picker.dart';
import 'month_picker.dart';
import 'range_picker.dart';
import 'week_picker.dart';

// layout defaults
const Duration _kPageScrollDuration = Duration(milliseconds: 200);
const double _kDayPickerRowHeight = 42.0;
const int _kMaxDayPickerRowCount = 6; // A 31 day month that starts on Saturday.
const double _kMonthPickerPortraitWidth = 330.0;
const EdgeInsetsGeometry _kContentPadding =
    EdgeInsets.symmetric(horizontal: 8.0);

/// Settings for the layout of the [DayPicker], [WeekPicker], [RangePicker]
/// and [MonthPicker].
class DatePickerLayoutSettings {
  /// Duration for scroll to previous or next page.
  final Duration pagesScrollDuration;

  /// Determines the scroll physics of a date picker widget.
  ///
  /// Can be null. In this case default physics for [ScrollView] will be used.
  final ScrollPhysics? scrollPhysics;

  /// Height of the one row in picker including headers.
  ///
  /// Default is [_kDayPickerRowHeight].
  final double dayPickerRowHeight;

  /// Width of the day based pickers.
  final double monthPickerPortraitWidth;

  ///
  final int maxDayPickerRowCount;

  /// Padding for the entire picker.
  final EdgeInsetsGeometry contentPadding;

  /// If the first dates from the next month should be shown
  /// to complete last week of the selected month.
  ///
  /// false by default.
  final bool showNextMonthStart;

  /// If the last dates from the previous month should be shown
  /// to complete first week of the selected month.
  ///
  /// false by default.
  final bool showPrevMonthEnd;
    
  /// Hide Month navigation row
  /// false by default.
  final bool hideMonthNavigationRow;

  /// Grid delegate for the picker according to [dayPickerRowHeight] and
  /// [maxDayPickerRowCount].
  SliverGridDelegate get dayPickerGridDelegate =>
      _DayPickerGridDelegate(dayPickerRowHeight, maxDayPickerRowCount);

  /// Maximum height of the day based picker according to [dayPickerRowHeight]
  /// and [maxDayPickerRowCount].
  ///
  /// Two extra rows:
  /// one for the day-of-week header and one for the month header.
  double get maxDayPickerHeight =>
      dayPickerRowHeight * (maxDayPickerRowCount + 2);

  /// Creates layout settings for the date picker.
  ///
  /// Usually used in [DayPicker], [WeekPicker], [RangePicker]
  /// and [MonthPicker].
  const DatePickerLayoutSettings({
    this.pagesScrollDuration = _kPageScrollDuration,
    this.dayPickerRowHeight = _kDayPickerRowHeight,
    this.monthPickerPortraitWidth = _kMonthPickerPortraitWidth,
    this.maxDayPickerRowCount = _kMaxDayPickerRowCount,
    this.contentPadding = _kContentPadding,
    this.showNextMonthStart = false,
    this.showPrevMonthEnd = false,
    this.hideMonthNavigationRow = false,
    this.scrollPhysics
  });
}


class _DayPickerGridDelegate extends SliverGridDelegate {
  final double _dayPickerRowHeight;
  final int _maxDayPickerRowCount;

  const _DayPickerGridDelegate(
      this._dayPickerRowHeight, this._maxDayPickerRowCount);

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    const int columnCount = DateTime.daysPerWeek;
    final double tileWidth = constraints.crossAxisExtent / columnCount;
    final double tileHeight = math.min(_dayPickerRowHeight,
        constraints.viewportMainAxisExtent / (_maxDayPickerRowCount + 1));
    return SliverGridRegularTileLayout(
      crossAxisCount: columnCount,
      mainAxisStride: tileHeight,
      crossAxisStride: tileWidth,
      childMainAxisExtent: tileHeight,
      childCrossAxisExtent: tileWidth,
      reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
    );
  }

  @override
  bool shouldRelayout(SliverGridDelegate oldDelegate) => false;
}
