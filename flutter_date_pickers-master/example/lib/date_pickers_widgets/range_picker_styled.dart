import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';

import '../event.dart';

/// Page with the [RangePicker] styled according to issue:
/// https://github.com/MariaMelnik/flutter_date_pickers/issues/49
class RangePickerPageStyled extends StatefulWidget {

  /// Custom events.
  final List<Event> events;

  ///
  const RangePickerPageStyled({
    Key? key,
    this.events = const []
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RangePickerPageStyledState();
}

class _RangePickerPageStyledState extends State<RangePickerPageStyled> {
  DateTime _firstDate = DateTime.now().subtract(Duration(days: 345));
  DateTime _lastDate = DateTime.now().add(Duration(days: 345));
  DatePeriod _selectedPeriod = DatePeriod(
      DateTime.now().subtract(Duration(days: 4)),
      DateTime.now().add(Duration(days: 8))
  );

  Color selectedPeriodStartColor = Colors.blue;
  Color selectedPeriodLastColor = Colors.blue;
  Color selectedPeriodMiddleColor = Colors.blue;

  @override
  void initState() {
    super.initState();

    DateTime selectedPeriodStart = DateTime.now().subtract(Duration(days: 4));
    DateTime selectedPeriodEnd = DateTime.now().add(Duration(days: 8));
    _selectedPeriod = DatePeriod(selectedPeriodStart, selectedPeriodEnd);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // defaults for styles
    selectedPeriodLastColor = Theme.of(context).accentColor;
    selectedPeriodMiddleColor = Theme.of(context).accentColor;
    selectedPeriodStartColor = Theme.of(context).accentColor;
  }

  @override
  Widget build(BuildContext context) {
    Color middleBgColor = Color.fromRGBO(237, 237, 250, 1);
    DecorationImage circleImg = DecorationImage(
        image: AssetImage('images/bg.png'),
        fit: BoxFit.contain
    );

    // add selected colors to default settings
    DatePickerRangeStyles styles = DatePickerRangeStyles(
      selectedPeriodLastDecoration: BoxDecoration(
          color: middleBgColor,
          gradient: LinearGradient(
              colors: [middleBgColor, Colors.transparent],
              stops: [0.5, 0.5]
          ),
          image: circleImg,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(24.0),
              bottomRight: Radius.circular(24.0))
      ),
      selectedPeriodStartDecoration: BoxDecoration(
        color: middleBgColor,
        gradient: LinearGradient(
            colors: [Colors.transparent, middleBgColor,],
            stops: [0.5, 0.5]
        ),
        image: circleImg,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24.0),
            bottomLeft: Radius.circular(24.0)
        ),
      ),
      selectedPeriodMiddleDecoration: BoxDecoration(
          color: middleBgColor,
          shape: BoxShape.rectangle
      ),
    );

    return Flex(
      direction: MediaQuery.of(context).orientation == Orientation.portrait
          ? Axis.vertical
          : Axis.horizontal,
      children: <Widget>[
        Expanded(
          child: RangePicker(
            selectedPeriod: _selectedPeriod,
            onChanged: _onSelectedDateChanged,
            firstDate: _firstDate,
            lastDate: _lastDate,
            datePickerStyles: styles,
            eventDecorationBuilder: _eventDecorationBuilder,
            selectableDayPredicate: _isSelectableCustom,
            onSelectionError: _onSelectionError,
            datePickerLayoutSettings: DatePickerLayoutSettings(
                showNextMonthStart: true,
                showPrevMonthEnd: true
            ),
          ),
        ),
        Container(
          child: Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Selected date styles",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                _selectedBlock()
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Block with show information about selected date
  // and boundaries of the selected period.
  Widget _selectedBlock() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _selectedPeriod != null
          ? Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
          child: Text("Selected period boundaries:"),
        ),
        Text(_selectedPeriod.start.toString()),
        Text(_selectedPeriod.end.toString()),
      ])
          : Container()
    ],
  );

  void _onSelectedDateChanged(DatePeriod newPeriod) {
    setState(() {
      _selectedPeriod = newPeriod;
    });
  }

  EventDecoration? _eventDecorationBuilder(DateTime date) {
    List<DateTime> eventsDates = widget.events
        .map<DateTime>((Event e) => e.date)
        .toList();

    bool isEventDate = eventsDates.any((DateTime d) =>
    date.year == d.year
        && date.month == d.month
        && d.day == date.day);

    BoxDecoration roundedBorder = BoxDecoration(
        border: Border.all(
          color: Colors.green,
        ),
        borderRadius: BorderRadius.all(Radius.circular(3.0))
    );

    return isEventDate
        ? EventDecoration(boxDecoration: roundedBorder)
        : null;
  }

  // ignore: prefer_expression_function_bodies
  bool _isSelectableCustom (DateTime day) {
    DateTime now = DateTime.now();
    DateTime yesterday = now.subtract(Duration(days: 1));
    DateTime tomorrow = now.add(Duration(days: 1));
    bool isYesterday = _sameDate(day, yesterday);
    bool isTomorrow = _sameDate(day, tomorrow);

    return !isYesterday && !isTomorrow;

    // return true;
//    return day.weekday < 6;
//    return day.day != DateTime.now().add(Duration(days: 7)).day ;
  }

  void _onSelectionError(UnselectablePeriodException exception) {
    DatePeriod errorPeriod = exception.period;

    // If user supposed to set another start of the period.
    bool selectStart = _selectedPeriod.start != errorPeriod.start;

    DateTime newSelection = selectStart
        ? errorPeriod.start
        : errorPeriod.end;

    DatePeriod newPeriod = DatePeriod(newSelection, newSelection);

    setState(() {
      _selectedPeriod = newPeriod;
    });
  }

  // 0 is Sunday, 6 is Saturday
  DayHeaderStyle _dayHeaderStyleBuilder(int weekday) {
    bool isWeekend = weekday == 0 || weekday == 6;

    return DayHeaderStyle(
        textStyle: TextStyle(
            color: isWeekend ? Colors.red : Colors.teal
        )
    );
  }
}


bool _sameDate(DateTime first, DateTime second) =>
      first.year == second.year 
      && first.month == second.month 
      && first.day == second.day;