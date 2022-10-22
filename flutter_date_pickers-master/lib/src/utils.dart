/// Bunch of useful functions for date pickers.
class DatePickerUtils {
  /// Returns if two objects have same year, month and day.
  /// Time doesn't matter.
  static bool sameDate(DateTime dateTimeOne, DateTime dateTimeTwo) =>
     dateTimeOne.year == dateTimeTwo.year &&
     dateTimeOne.month == dateTimeTwo.month &&
     dateTimeOne.day == dateTimeTwo.day;

  /// Returns if two objects have same year and month.
  /// Day and time don't matter/
  static bool sameMonth(DateTime dateTimeOne, DateTime dateTimeTwo) =>
      dateTimeOne.year == dateTimeTwo.year
      && dateTimeOne.month == dateTimeTwo.month;


  // Do not use this directly - call getDaysInMonth instead.
  static const List<int> _daysInMonth = <int>[
    31,
    -1,
    31,
    30,
    31,
    30,
    31,
    31,
    30,
    31,
    30,
    31
  ];


  /// Returns the number of days in a month, according to the proleptic
  /// Gregorian calendar.
  ///
  /// This applies the leap year logic introduced by the Gregorian reforms of
  /// 1582. It will not give valid results for dates prior to that time.
  static int getDaysInMonth(int year, int month) {
    if (month == DateTime.february) {
      final bool isLeapYear =
          (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
      return isLeapYear ? 29 : 28;
    }
    return _daysInMonth[month - 1];
  }


  /// Returns number of months between [startDate] and [endDate]
  static int monthDelta(DateTime startDate, DateTime endDate) =>
     (endDate.year - startDate.year) * 12 +
        endDate.month -
        startDate.month;


  /// Add months to a month truncated date.
  static DateTime addMonthsToMonthDate(DateTime monthDate, int monthsToAdd) =>
    // year is switched automatically if new month > 12
    DateTime(monthDate.year, monthDate.month + monthsToAdd);


  /// Returns number of years between [startDate] and [endDate]
  static int yearDelta(DateTime startDate, DateTime endDate) =>
     endDate.year - startDate.year;


  /// Returns start of the first day of the week with given day.
  ///
  /// Start of the week calculated using firstDayIndex which is int from 0 to 6
  /// where 0 points to Sunday and 6 points to Saturday.
  /// (according to MaterialLocalization.firstDayIfWeekIndex)
  static DateTime getFirstDayOfWeek(DateTime day, int firstDayIndex) {
    // from 1 to 7 where 1 points to Monday and 7 points to Sunday
    int weekday = day.weekday;

    // to match weekdays where Sunday is 7 not 0
    if (firstDayIndex == 0) firstDayIndex = 7;

    int diff = weekday - firstDayIndex;
    if (diff < 0) diff = 7 + diff;

    DateTime firstDayOfWeek = day.subtract(Duration(days: diff));
    firstDayOfWeek = startOfTheDay(firstDayOfWeek);
    return firstDayOfWeek;
  }

  /// Returns end of the last day of the week with given day.
  ///
  /// Start of the week calculated using firstDayIndex which is int from 0 to 6
  /// where 0 points to Sunday and 6 points to Saturday.
  /// (according to MaterialLocalization.firstDayIfWeekIndex)
  static DateTime getLastDayOfWeek(DateTime day, int firstDayIndex) {
    // from 1 to 7 where 1 points to Monday and 7 points to Sunday
    int weekday = day.weekday;

    // to match weekdays where Sunday is 7 not 0
    if (firstDayIndex == 0) firstDayIndex = 7;

    int lastDayIndex = firstDayIndex - 1;
    if (lastDayIndex == 0) lastDayIndex = 7;

    int diff = lastDayIndex - weekday;
    if (diff < 0) diff = 7 + diff;

    DateTime lastDayOfWeek = day.add(Duration(days: diff));
    lastDayOfWeek = endOfTheDay(lastDayOfWeek);
    return lastDayOfWeek;
  }

  /// Returns end of the given day.
  ///
  /// End time is 1 millisecond before start of the next day.
  static DateTime endOfTheDay(DateTime date) {
    DateTime tomorrowStart = DateTime(date.year, date.month, date.day + 1);
    DateTime result = tomorrowStart.subtract(const Duration(milliseconds: 1));

    return result;
  }


  /// Returns start of the given day.
  ///
  /// Start time is 00:00:00.
  static DateTime startOfTheDay(DateTime date) =>
     DateTime(date.year, date.month, date.day);

  /// Returns first shown date for the [curMonth].
  ///
  /// First shown date is not always 1st day of the [curMonth].
  /// It can be day from previous month if [showEndOfPrevMonth] is true.
  ///
  /// If [showEndOfPrevMonth] is true empty day cells before 1st [curMonth]
  /// are filled with days from the previous month.
  static DateTime firstShownDate({
      required DateTime curMonth,
      required bool showEndOfPrevMonth,
      required int firstDayOfWeekFromSunday}) {

    DateTime result = DateTime(curMonth.year, curMonth.month, 1);

    if (showEndOfPrevMonth) {
      int firstDayOffset = computeFirstDayOffset(curMonth.year, curMonth.month,
          firstDayOfWeekFromSunday);
      if (firstDayOffset == 0) return result;


      int prevMonth = curMonth.month - 1;
      if (prevMonth < 1) prevMonth = 12;

      int prevYear = prevMonth == 12
        ? curMonth.year - 1
        : curMonth.year;

      int daysInPrevMonth = getDaysInMonth(prevYear, prevMonth);
      int firstShownDay = daysInPrevMonth - firstDayOffset + 1;
      result = DateTime(prevYear, prevMonth, firstShownDay);
    }

    return result;
  }


  /// Returns last shown date for the [curMonth].
  ///
  /// Last shown date is not always last day of the [curMonth].
  /// It can be day from next month if [showStartNextMonth] is true.
  ///
  /// If [showStartNextMonth] is true empty day cells after last day
  /// of [curMonth] are filled with days from the next month.
  static DateTime lastShownDate({
      required DateTime curMonth,
      required bool showStartNextMonth,
      required int firstDayOfWeekFromSunday}) {

    int daysInCurMonth = getDaysInMonth(curMonth.year, curMonth.month);
    DateTime result = DateTime(curMonth.year, curMonth.month, daysInCurMonth);

    if (showStartNextMonth) {
      int firstDayOffset = computeFirstDayOffset(curMonth.year, curMonth.month,
          firstDayOfWeekFromSunday);

      int totalDays = firstDayOffset + daysInCurMonth;
      int trailingDaysCount = 7 - totalDays % 7;
      bool fullWeekTrailing = trailingDaysCount == 7;
      if (fullWeekTrailing) return result;

      result = DateTime(curMonth.year, curMonth.month + 1, trailingDaysCount);
    }

    return result;
  }

  /// Computes the offset from the first day of week that the first day of the
  /// [month] falls on.
  ///
  /// For example, September 1, 2017 falls on a Friday, which in the calendar
  /// localized for United States English appears as:
  ///
  /// ```
  /// S M T W T F S
  /// _ _ _ _ _ 1 2
  /// ```
  ///
  /// The offset for the first day of the months is the number of leading blanks
  /// in the calendar, i.e. 5.
  ///
  /// The same date localized for the Russian calendar has a different offset,
  /// because the first day of week is Monday rather than Sunday:
  ///
  /// ```
  /// M T W T F S S
  /// _ _ _ _ 1 2 3
  /// ```
  ///
  /// So the offset is 4, rather than 5.
  ///
  /// This code consolidates the following:
  ///
  /// - [DateTime.weekday] provides a 1-based index into days of week, with 1
  ///   falling on Monday.
  /// - MaterialLocalizations.firstDayOfWeekIndex provides a 0-based index
  ///   into the MaterialLocalizations.narrowWeekdays list.
  /// - MaterialLocalizations.narrowWeekdays list provides localized names of
  ///   days of week, always starting with Sunday and ending with Saturday.
  static int computeFirstDayOffset(
      int year, int month, int firstDayOfWeekFromSunday) {
    // 0-based day of week, with 0 representing Monday.
    final int weekdayFromMonday = DateTime(year, month).weekday - 1;
    // firstDayOfWeekFromSunday recomputed to be Monday-based
    final int firstDayOfWeekFromMonday = (firstDayOfWeekFromSunday - 1) % 7;
    // Number of days between the first day of week appearing on the calendar,
    // and the day corresponding to the 1-st of the month.
    return (weekdayFromMonday - firstDayOfWeekFromMonday) % 7;
  }

  /// Returns earliest [DateTime] from the list.
  ///
  /// [dates] must not be null.
  /// In case it is null, [ArgumentError] will be thrown.
  static DateTime getEarliestFromList(List<DateTime> dates) {
    ArgumentError.checkNotNull(dates, "dates");

    return dates.fold(dates[0], getEarliest);
  }

  /// Returns earliest [DateTime] from two.
  ///
  /// If two [DateTime]s is the same moment first ([a]) will be return.
  static DateTime getEarliest(DateTime a, DateTime b)
    => a.isBefore(b) ? a : b;
}
