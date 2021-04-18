import 'package:analytics_integration/single_item_tile.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// initialize your firebase project
  await Firebase.initializeApp();
  runApp(FlutterAnalyticsApp());
}

class FlutterAnalyticsApp extends StatelessWidget {
  /// create instance of FirebaseAnalytics as [analytics]
  static FirebaseAnalytics analytics = FirebaseAnalytics();

  /// create observer for FirebaseAnalytics as [observer]
  /// this observer sends events to Firebase Analytics when the
  /// currently active route changes.
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Analytics',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      /// this is used to observe navigation changes in the app
      /// and sending data back to Firebase Analytics
      navigatorObservers: <NavigatorObserver>[observer],
      home: FlutterAnalyticsHome(
        title: 'Flutter Analytics',
        analytics: analytics,
        observer: observer,
      ),
    );
  }
}

class FlutterAnalyticsHome extends StatefulWidget {
  final String title;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  FlutterAnalyticsHome({
    Key key,
    this.title,
    this.analytics,
    this.observer,
  }) : super(key: key);

  @override
  _FlutterAnalyticsHomeState createState() => _FlutterAnalyticsHomeState();
}

class _FlutterAnalyticsHomeState extends State<FlutterAnalyticsHome> {
  FirebaseAnalytics _analytics;

  @override
  void initState() {
    /// initializing data to local variable [_analytics] for Firebase Analytics
    /// that we made before for local use
    _analytics = widget.analytics;
    //// below three events are related to user which we are
    //// sending to Firebase Analytics
    _setUserIdInAnalytics();
    _setUserPropertyInAnalytics();
    _currentScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
          child: Text(widget.title),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(
              height: 16,
            ),
            SingleItemTile(
              itemName: 'Carrot',
              analytics: _analytics,
              quantity: 1,
              price: '100Rs',
            ),
            SizedBox(
              height: 16,
            ),
            SingleItemTile(
              itemName: 'Baby Carrot',
              analytics: _analytics,
              quantity: .5,
              price: '50Rs',
            ),
            SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }

  //// to create a unique user identifier for Analytics
  //// send user id(if you app has)
  Future<void> _setUserIdInAnalytics() async {
    await _analytics.setUserId('alksj39hnfn49skvnghqwp40sm');
  }

  //// sending user related field to Analytics
  /// below [name] is the name of the user property to set
  /// [value] is the values of that property
  Future<void> _setUserPropertyInAnalytics() async {
    await _analytics.setUserProperty(
      name: 'email',
      value: 'johndoe@gmail.com',
    );
  }

  /// Setting the current Screen of the app in [screenName]
  /// and sending back to Analytics
  Future<void> _currentScreen() async {
    await _analytics.setCurrentScreen(
      screenName: 'FlutterAnalyticsHome',
      screenClassOverride: 'FlutterAnalyticsHome',
    );
  }
}
