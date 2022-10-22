import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'date_picker_keys.dart';
import 'date_picker_styles.dart';
import 'layout_settings.dart';
import 'semantic_sorting.dart';
import 'utils.dart';

const Locale _defaultLocale = Locale('en', 'US');

/// Month picker widget.
class MonthPicker extends StatefulWidget {
  /// Month picker widget.
  MonthPicker(
      {Key? key,
      required this.selectedDate,
      required this.onChanged,
      required this.firstDate,
      required this.lastDate,
      this.datePickerLayoutSettings = const DatePickerLayoutSettings(),
      this.datePickerKeys,
      required this.datePickerStyles})
      : assert(!firstDate.isAfter(lastDate)),
        assert(!selectedDate.isBefore(firstDate)),
        assert(!selectedDate.isAfter(lastDate)),
        super(key: key);

  /// The currently selected date.
  ///
  /// This date is highlighted in the picker.
  final DateTime selectedDate;

  /// Called when the user picks a month.
  final ValueChanged<DateTime> onChanged;

  /// The earliest date the user is permitted to pick.
  final DateTime firstDate;

  /// The latest date the user is permitted to pick.
  final DateTime lastDate;

  /// Layout settings what can be customized by user
  final DatePickerLayoutSettings datePickerLayoutSettings;

  /// Some keys useful for integration tests
  final DatePickerKeys? datePickerKeys;

  /// Styles what can be customized by user
  final DatePickerStyles datePickerStyles;

  @override
  State<StatefulWidget> createState() => _MonthPickerState();
}

class _MonthPickerState extends State<MonthPicker> {
  PageController _monthPickerController = PageController();

  Locale locale = _defaultLocale;
  MaterialLocalizations localizations = _defaultLocalizations;

  TextDirection textDirection = TextDirection.ltr;

  DateTime _todayDate = DateTime.now();
  DateTime _previousYearDate = DateTime(DateTime.now().year - 1);
  DateTime _nextYearDate = DateTime(DateTime.now().year + 1);

  DateTime _currentDisplayedYearDate = DateTime.now();

  Timer? _timer;

  /// True if the earliest allowable year is displayed.
  bool get _isDisplayingFirstYear =>
      !_currentDisplayedYearDate.isAfter(DateTime(widget.firstDate.year));

  /// True if the latest allowable year is displayed.
  bool get _isDisplayingLastYear =>
      !_currentDisplayedYearDate.isBefore(DateTime(widget.lastDate.year));

  @override
  void initState() {
    super.initState();
    // Initially display the pre-selected date.
    final int yearPage =
        DatePickerUtils.yearDelta(widget.firstDate, widget.selectedDate);

    _monthPickerController.dispose();
    _monthPickerController = PageController(initialPage: yearPage);
    _handleYearPageChanged(yearPage);
    _updateCurrentDate();
  }

  @override
  void didUpdateWidget(MonthPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDate != oldWidget.selectedDate) {
      final int yearPage =
          DatePickerUtils.yearDelta(widget.firstDate, widget.selectedDate);
      _monthPickerController = PageController(initialPage: yearPage);
      _handleYearPageChanged(yearPage);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    try {
      locale = Localizations.localeOf(context);

      MaterialLocalizations? curLocalizations =
          Localizations.of<MaterialLocalizations>(
              context, MaterialLocalizations);
      if (curLocalizations != null && localizations != curLocalizations) {
        localizations = curLocalizations;
      }

      textDirection = Directionality.of(context);

      // No MaterialLocalizations or Directionality or Locale was found
      // and ".of" method throws error
      // trying to cast null to MaterialLocalizations.
    } on TypeError catch (_) {}
  }

  void _updateCurrentDate() {
    _todayDate = DateTime.now();
    final DateTime tomorrow =
        DateTime(_todayDate.year, _todayDate.month, _todayDate.day + 1);
    Duration timeUntilTomorrow = tomorrow.difference(_todayDate);
    timeUntilTomorrow +=
        const Duration(seconds: 1); // so we don't miss it by rounding
    _timer?.cancel();
    _timer = Timer(timeUntilTomorrow, () {
      setState(_updateCurrentDate);
    });
  }

  /// Add years to a year truncated date.
  DateTime _addYearsToYearDate(DateTime yearDate, int yearsToAdd) =>
      DateTime(yearDate.year + yearsToAdd);

  Widget _buildItems(BuildContext context, int index) {
    final DateTime year = _addYearsToYearDate(widget.firstDate, index);

    final ThemeData theme = Theme.of(context);
    DatePickerStyles styles = widget.datePickerStyles;
    styles = styles.fulfillWithTheme(theme);

    return _MonthPicker(
      key: ValueKey<DateTime>(year),
      selectedDate: widget.selectedDate,
      currentDate: _todayDate,
      onChanged: widget.onChanged,
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
      datePickerLayoutSettings: widget.datePickerLayoutSettings,
      displayedYear: year,
      selectedPeriodKey: widget.datePickerKeys?.selectedPeriodKeys,
      datePickerStyles: styles,
      locale: locale,
      localizations: localizations,
    );
  }

  void _handleNextYear() {
    if (!_isDisplayingLastYear) {
      String yearStr = localizations.formatYear(_nextYearDate);
      SemanticsService.announce(yearStr, textDirection);
      _monthPickerController.nextPage(
          duration: widget.datePickerLayoutSettings.pagesScrollDuration,
          curve: Curves.ease);
    }
  }

  void _handlePreviousYear() {
    if (!_isDisplayingFirstYear) {
      String yearStr = localizations.formatYear(_previousYearDate);
      SemanticsService.announce(yearStr, textDirection);
      _monthPickerController.previousPage(
          duration: widget.datePickerLayoutSettings.pagesScrollDuration,
          curve: Curves.ease);
    }
  }

  void _handleYearPageChanged(int yearPage) {
    setState(() {
      _previousYearDate = _addYearsToYearDate(widget.firstDate, yearPage - 1);
      _currentDisplayedYearDate =
          _addYearsToYearDate(widget.firstDate, yearPage);
      _nextYearDate = _addYearsToYearDate(widget.firstDate, yearPage + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    int yearsCount =
        DatePickerUtils.yearDelta(widget.firstDate, widget.lastDate) + 1;

    return SizedBox(
      width: widget.datePickerLayoutSettings.monthPickerPortraitWidth,
      height: widget.datePickerLayoutSettings.maxDayPickerHeight,
      child: Stack(
        children: <Widget>[
          Semantics(
            sortKey: YearPickerSortKey.calendar,
            child: PageView.builder(
              key: ValueKey<DateTime>(widget.selectedDate),
              controller: _monthPickerController,
              scrollDirection: Axis.horizontal,
              itemCount: yearsCount,
              itemBuilder: _buildItems,
              onPageChanged: _handleYearPageChanged,
            ),
          ),
          PositionedDirectional(
            top: 0.0,
            start: 8.0,
            child: Semantics(
              sortKey: YearPickerSortKey.previousYear,
              child: IconButton(
                key: widget.datePickerKeys?.previousPageIconKey,
                icon: widget.datePickerStyles.prevIcon,
                tooltip: _isDisplayingFirstYear
                    ? null
                    : '${localizations.formatYear(_previousYearDate)}',
                onPressed: _isDisplayingFirstYear ? null : _handlePreviousYear,
              ),
            ),
          ),
          PositionedDirectional(
            top: 0.0,
            end: 8.0,
            child: Semantics(
              sortKey: YearPickerSortKey.nextYear,
              child: IconButton(
                key: widget.datePickerKeys?.nextPageIconKey,
                icon: widget.datePickerStyles.nextIcon,
                tooltip: _isDisplayingLastYear
                    ? null
                    : '${localizations.formatYear(_nextYearDate)}',
                onPressed: _isDisplayingLastYear ? null : _handleNextYear,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static MaterialLocalizations get _defaultLocalizations =>
      MaterialLocalizationEn(
        twoDigitZeroPaddedFormat:
            intl.NumberFormat('00', _defaultLocale.toString()),
        fullYearFormat: intl.DateFormat.y(_defaultLocale.toString()),
        longDateFormat: intl.DateFormat.yMMMMEEEEd(_defaultLocale.toString()),
        shortMonthDayFormat: intl.DateFormat.MMMd(_defaultLocale.toString()),
        decimalFormat:
            intl.NumberFormat.decimalPattern(_defaultLocale.toString()),
        shortDateFormat: intl.DateFormat.yMMMd(_defaultLocale.toString()),
        mediumDateFormat: intl.DateFormat.MMMEd(_defaultLocale.toString()),
        compactDateFormat: intl.DateFormat.yMd(_defaultLocale.toString()),
        yearMonthFormat: intl.DateFormat.yMMMM(_defaultLocale.toString()),
      );
}

class _MonthPicker extends StatelessWidget {
  /// The month whose days are displayed by this picker.
  final DateTime displayedYear;

  /// The earliest date the user is permitted to pick.
  final DateTime firstDate;

  /// The latest date the user is permitted to pick.
  final DateTime lastDate;

  /// The currently selected date.
  ///
  /// This date is highlighted in the picker.
  final DateTime selectedDate;

  /// The current date at the time the picker is displayed.
  final DateTime currentDate;

  /// Layout settings what can be customized by user
  final DatePickerLayoutSettings datePickerLayoutSettings;

  /// Called when the user picks a day.
  final ValueChanged<DateTime> onChanged;

  ///  Key fo selected month (useful for integration tests)
  final Key? selectedPeriodKey;

  /// Styles what can be customized by user
  final DatePickerStyles datePickerStyles;

  final MaterialLocalizations localizations;

  final Locale locale;

  _MonthPicker(
      {required this.displayedYear,
      required this.firstDate,
      required this.lastDate,
      required this.selectedDate,
      required this.currentDate,
      required this.onChanged,
      required this.datePickerLayoutSettings,
      required this.datePickerStyles,
      required this.localizations,
      required this.locale,
      this.selectedPeriodKey,
      Key? key})
      : assert(!firstDate.isAfter(lastDate)),
        assert(selectedDate.isAfter(firstDate) ||
            selectedDate.isAtSameMomentAs(firstDate)),
        super(key: key);

  // We only need to know if month of passed day
  // before the month of the firstDate or after the month of the lastDate.
  //
  // Don't need to compare day and time.
  bool _isDisabled(DateTime month) {
    DateTime beginningOfTheFirstDateMonth =
        DateTime(firstDate.year, firstDate.month);
    DateTime endOfTheLastDateMonth = DateTime(lastDate.year, lastDate.month + 1)
        .subtract(Duration(microseconds: 1));

    return month.isAfter(endOfTheLastDateMonth) ||
        month.isBefore(beginningOfTheFirstDateMonth);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final int monthsInYear = 12;
    final int year = displayedYear.year;
    final int day = 1;

    final List<Widget> labels = <Widget>[];

    for (int i = 0; i < monthsInYear; i += 1) {
      final int month = i + 1;
      final DateTime monthToBuild = DateTime(year, month, day);

      final bool disabled = _isDisabled(monthToBuild);
      final bool isSelectedMonth =
          selectedDate.year == year && selectedDate.month == month;

      BoxDecoration? decoration;
      TextStyle? itemStyle = themeData.textTheme.bodyText2;

      if (isSelectedMonth) {
        itemStyle = datePickerStyles.selectedDateStyle;
        decoration = datePickerStyles.selectedSingleDateDecoration;
      } else if (disabled) {
        itemStyle = datePickerStyles.disabledDateStyle;
      } else if (currentDate.year == year && currentDate.month == month) {
        // The current month gets a different text color.
        itemStyle = datePickerStyles.currentDateStyle;
      } else {
        itemStyle = datePickerStyles.defaultDateTextStyle;
      }

      String monthStr = _getMonthStr(monthToBuild);

      Widget monthWidget = Container(
        decoration: decoration,
        child: Center(
          child: Semantics(
            // We want the day of month to be spoken first irrespective of the
            // locale-specific preferences or TextDirection. This is because
            // an accessibility user is more likely to be interested in the
            // day of month before the rest of the date, as they are looking
            // for the day of month. To do that we prepend day of month to the
            // formatted full date.
            label: '${localizations.formatDecimal(month)}, '
                '${localizations.formatFullDate(monthToBuild)}',
            selected: isSelectedMonth,
            child: ExcludeSemantics(
              child: Text(monthStr, style: itemStyle),
            ),
          ),
        ),
      );

      if (!disabled) {
        monthWidget = GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            DatePickerUtils.sameMonth(firstDate, monthToBuild)
                ? onChanged(firstDate)
                : onChanged(monthToBuild);
          },
          child: monthWidget,
        );
      }
      labels.add(monthWidget);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: <Widget>[
          Container(
            height: datePickerLayoutSettings.dayPickerRowHeight,
            child: Center(
              child: ExcludeSemantics(
                child: Text(
                  localizations.formatYear(displayedYear),
                  key: selectedPeriodKey,
                  style: datePickerStyles.displayedPeriodTitle,
                ),
              ),
            ),
          ),
          Flexible(
            child: GridView.count(
              physics: datePickerLayoutSettings.scrollPhysics,
              crossAxisCount: 4,
              children: labels,
            ),
          ),
        ],
      ),
    );
  }

  // Returns only month made with intl.DateFormat.MMM() for current [locale].
  // We can'r use [localizations] here because MaterialLocalizations doesn't
  // provide short month string.
  String _getMonthStr(DateTime date) {
    String month = intl.DateFormat.MMM(locale.toString()).format(date);
    return month;
  }
}
