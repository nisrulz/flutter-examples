/// Event for the date pickers.
class Event {

  /// Event's date.
  final DateTime date;

  /// Event's title.
  final String dis;

  ///
  Event(this.date, this.dis)
      : assert(date != null),
        assert(dis != null);
}
