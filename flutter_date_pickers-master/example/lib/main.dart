import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'date_pickers_widgets/day_picker_page.dart';
import 'date_pickers_widgets/days_picker_page.dart';
import 'date_pickers_widgets/month_picker_page.dart';
import 'date_pickers_widgets/range_picker_page.dart';
import 'date_pickers_widgets/week_picker_page.dart';

import 'event.dart';

void main() {
  runApp(MyApp());
}

///
class MyApp extends StatelessWidget {

  @override
    // ignore: prefer_expression_function_bodies
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
         supportedLocales: [
           const Locale('en', 'US'), // American English
           const Locale('ru', 'RU'), // Russian
           const Locale("pt") // Portuguese
      ],
      debugShowCheckedModeBanner: false,
      title: 'Date pickers demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(
        title: 'flutter_date_pickers Demo',
      ),
    );
  }
}

/// Start page.
class MyHomePage extends StatefulWidget {
  /// Page title.
  final String title;

  ///
  MyHomePage({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  DateTime startOfPeriod = DateTime.now().subtract(Duration(days: 10));
  DateTime endOfPeriod = DateTime.now().add(Duration(days: 10));
  int _selectedTab = 0;

  final List<Widget> datePickers = <Widget>[
    DayPickerPage(events: events,),
    DaysPickerPage(),
    WeekPickerPage(events: events,),
    RangePickerPage(events: events,),
    MonthPickerPage()
  ];

  @override
    // ignore: prefer_expression_function_bodies
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(letterSpacing: 1.15),
        ),
      ),
      body: datePickers[_selectedTab],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            canvasColor: Colors.blueGrey,
            textTheme: Theme.of(context).textTheme.copyWith(
                caption: TextStyle(color: Colors.white.withOpacity(0.5)))),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.date_range), label: "Day"),
            BottomNavigationBarItem(
                icon: Icon(Icons.date_range), label: "Days"),
            BottomNavigationBarItem(
                icon: Icon(Icons.date_range), label: "Week"),
            BottomNavigationBarItem(
                icon: Icon(Icons.date_range), label: "Range"),
            BottomNavigationBarItem(
                icon: Icon(Icons.date_range), label: "Month"),
          ],
          fixedColor: Colors.yellow,
          currentIndex: _selectedTab,
          onTap: (newIndex) {
            setState(() {
              _selectedTab = newIndex;
            });
          },
        ),
      ),
    );
  }
}

/// Mock events.
final List<Event> events = [
  Event(DateTime.now(), "Today event"),
  Event(DateTime.now().subtract(Duration(days: 3)), "Ev1"),
  Event(DateTime.now().subtract(Duration(days: 13)), "Ev2"),
  Event(DateTime.now().subtract(Duration(days: 30)), "Ev3"),
  Event(DateTime.now().add(Duration(days: 3)), "Ev4"),
  Event(DateTime.now().add(Duration(days: 13)), "Ev5"),
  Event(DateTime.now().add(Duration(days: 30)), "Ev6"),
];