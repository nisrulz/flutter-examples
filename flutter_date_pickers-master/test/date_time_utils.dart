/// Bunch of useful functions for date pickers.
class DateTimeUtils {
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
  static DateTime endOfTheDay(DateTime date) =>
      DateTime(date.year, date.month, date.day)
          .add(const Duration(days: 1))
          .subtract(const Duration(milliseconds: 1));

  /// Returns start of the given day.
  ///
  /// Start time is 00:00:00.
  static DateTime startOfTheDay(DateTime date) =>
      DateTime(date.year, date.month, date.day);


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
