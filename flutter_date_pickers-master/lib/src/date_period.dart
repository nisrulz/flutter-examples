/// Date period.
class DatePeriod {
  /// Start of this period.
  final DateTime start;

  /// End of this period.
  final DateTime end;

  ///
  const DatePeriod(this.start, this.end)
      : assert(start != null),
        assert(end != null);
}
