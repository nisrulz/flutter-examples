import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  runZonedGuarded(() {
    runApp(App());
  }, (error, stackTrace) {
    // Pass all uncaught errors from the framework to Crashlytics.
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}

class App extends StatelessWidget {

  //initialise firebase and crashlytics
  Future<void> _initializeFirebase() async {
    await Firebase.initializeApp();
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Crash App"),
        ),
        body: FutureBuilder(
          future: _initializeFirebase(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Unable to initialise Firebase"),
              );
            }
            //firebase and crashlytics initialise complete
            if (snapshot.connectionState == ConnectionState.done) {
              return CrashApp();
            }
            return Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  Text("Initialising Firebase")
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class CrashApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                //custom Crashlytics log message
                FirebaseCrashlytics.instance.log("It's a bug");
              },
              child: Text("Custom Log")),
          const SizedBox(height: 10),
          ElevatedButton(
            child: Text('Crash the app'),
            onPressed: () {
              FirebaseCrashlytics.instance.crash();
            },
          ),
        ],
      ),
    );
  }
}
