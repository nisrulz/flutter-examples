import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';

import '../color_picker_dialog.dart';
import '../color_selector_btn.dart';
import '../event.dart';

/// Page with the [WeekPicker].
class WeekPickerPage extends StatefulWidget {
  /// Custom events.
  final List<Event> events;

  ///
  const WeekPickerPage({
    Key? key,
    this.events = const []
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WeekPickerPageState();
}

class _WeekPickerPageState extends State<WeekPickerPage> {
  DateTime _selectedDate = DateTime.now();
  DateTime _firstDate = DateTime.now().subtract(Duration(days: 45));
  DateTime _lastDate = DateTime.now().add(Duration(days: 45));
  DatePeriod? _selectedPeriod;

  Color selectedPeriodStartColor = Colors.blue;
  Color selectedPeriodLastColor = Colors.blue;
  Color selectedPeriodMiddleColor = Colors.blue;

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
    // add selected colors to default settings
    DatePickerRangeStyles styles = DatePickerRangeStyles(
      selectedPeriodLastDecoration: BoxDecoration(
          color: selectedPeriodLastColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0))),
      selectedPeriodStartDecoration: BoxDecoration(
        color: selectedPeriodStartColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0), bottomLeft: Radius.circular(10.0)),
      ),
      selectedPeriodMiddleDecoration: BoxDecoration(
          color: selectedPeriodMiddleColor, shape: BoxShape.rectangle),
    );

    return Flex(
      direction: MediaQuery.of(context).orientation == Orientation.portrait
          ? Axis.vertical
          : Axis.horizontal,
      children: <Widget>[
        Expanded(
          child: WeekPicker(
            selectedDate: _selectedDate,
            onChanged: _onSelectedDateChanged,
            firstDate: _firstDate,
            lastDate: _lastDate,
            datePickerStyles: styles,
            onSelectionError: _onSelectionError,
            selectableDayPredicate: _isSelectableCustom,
            eventDecorationBuilder: _eventDecorationBuilder,
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
                _stylesBlock(),
                _selectedBlock()
              ],
            ),
          ),
        ),
      ],
    );
  }

  // block witt color buttons insede
  Widget _stylesBlock() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ColorSelectorBtn(
              title: "Start",
              color: selectedPeriodStartColor,
              showDialogFunction: _showSelectedStartColorDialog),
          SizedBox(
            width: 12.0,
          ),
          ColorSelectorBtn(
              title: "Middle",
              color: selectedPeriodMiddleColor,
              showDialogFunction: _showSelectedMiddleColorDialog),
          SizedBox(
            width: 12.0,
          ),
          ColorSelectorBtn(
              title: "End",
              color: selectedPeriodLastColor,
              showDialogFunction: _showSelectedEndColorDialog),
        ],
      ),
    );

  // Block with  information about selected date
  // and boundaries of the selected period.
  Widget _selectedBlock() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text("Selected: $_selectedDate"),
        ),
        _selectedPeriod != null
            ? Column(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                  child: Text("Selected period boundaries:"),
                ),
                Text(_selectedPeriod!.start.toString()),
                Text(_selectedPeriod!.end.toString()),
              ])
            : Container()
      ],
    );

  // select background color for the first date of the selected period
  void _showSelectedStartColorDialog() async {
    Color? newSelectedColor = await showDialog(
        context: context,
        builder: (_) => ColorPickerDialog(
              selectedColor: selectedPeriodStartColor,
            ));

    if (newSelectedColor != null) {
      setState(() {
        selectedPeriodStartColor = newSelectedColor;
      });
    }
  }

  // select background color for the last date of the selected period
  void _showSelectedEndColorDialog() async {
    Color? newSelectedColor = await showDialog(
        context: context,
        builder: (_) => ColorPickerDialog(
              selectedColor: selectedPeriodLastColor,
            ));

    if (newSelectedColor != null) {
      setState(() {
        selectedPeriodLastColor = newSelectedColor;
      });
    }
  }

  // select background color for the middle dates of the selected period
  void _showSelectedMiddleColorDialog() async {
    Color newSelectedColor = await showDialog(
        context: context,
        builder: (_) => ColorPickerDialog(
              selectedColor: selectedPeriodMiddleColor,
            ));

    if (newSelectedColor != null) {
      setState(() {
        selectedPeriodMiddleColor = newSelectedColor;
      });
    }
  }

  void _onSelectedDateChanged(DatePeriod newPeriod) {
    setState(() {
      _selectedDate = newPeriod.start;
      _selectedPeriod = newPeriod;
    });
  }

  void _onSelectionError(Object e){
    if (e is UnselectablePeriodException) print("catch error: $e");
  }

// ignore: prefer_expression_function_bodies
  bool _isSelectableCustom (DateTime day) {
//    return day.weekday < 6;
    return day.day != DateTime.now().add(Duration(days: 7)).day ;
  }

  EventDecoration? _eventDecorationBuilder(DateTime date) {
    List<DateTime> eventsDates = widget.events
        .map<DateTime>((Event e) => e.date)
        .toList();

    bool isEventDate = eventsDates.any((DateTime d) => date.year == d.year
        && date.month == d.month
        && d.day == date.day);

    if (!isEventDate) return null;

    BoxDecoration roundedBorder = BoxDecoration(
        color: Colors.blue,
        border: Border.all(
          color: Colors.blue,
        ),
        borderRadius: BorderRadius.all(Radius.circular(3.0))
    );

    TextStyle? whiteText = Theme.of(context)
        .textTheme
        .bodyText2
        ?.copyWith(color: Colors.white);

    return isEventDate
        ? EventDecoration(boxDecoration: roundedBorder, textStyle: whiteText)
        : null;
  }
}
