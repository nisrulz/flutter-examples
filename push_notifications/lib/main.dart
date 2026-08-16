import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Push Notification demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String title = "Title will appear here";
  String messageData = "Message text will appear here";

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  Future<void> initState() async {
    super.initState();

/*
Message that we are getting from firebase will be of form:-
  {
    notification:{
      title:'Custom Title that we send from firebase cloud messaging',
      body:'Text of the message will appear here'
    },
    data:{
      Here the extra data like if we include image,etc optional data from firebase cloud messaging
    }
  }

For sending Push notification go to Grow and then cloud messaging, from there send new message by adding title 
and other fields as per requirement

*/
    // Request permission (iOS) and listen for messages.
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      setState(() {
        title = message.notification?.title ?? title;
        messageData = message.notification?.body ?? messageData;
        notification(context, title, messageData);
      });
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      setState(() {
        title = message.notification?.title ?? title;
        messageData = message.notification?.body ?? messageData;
        notification(context, title, messageData);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Push Notification Demo'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Column(
            children: <Widget>[
              Text(
                '$title',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                messageData,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }

// this function will be called when a push notification is recieved and show as alert dialog along with
// title and message body
  Future notification(
      BuildContext context, String title, String messageText) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            buttonPadding: EdgeInsets.all(10.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  messageText,
                  style: TextStyle(fontSize: 16.0),
                )
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context), child: Text('Ok'))
            ],
          );
        });
  }
}
