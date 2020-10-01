import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Alert Box Demo',
      //ideal to use with notch screen users
      home: SafeArea(child: MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                //call our exit with confirmation function
                exit(context);
              }),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text("Demo Of Alert Box,\nTap the exit button on the Appbar to see it working",style: TextStyle(fontSize: 22),textAlign: TextAlign.center,),
        ),
      ),
    );
  }


  exit(BuildContext context) {
    //creates a dismissible modal route which is displayed on top of the sceen.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Exiting this page.."),
          content: Text("Are you sure you want Exit this page?",style: TextStyle(fontSize: 20),),
          actions: <Widget>[
            FlatButton(
              child: Text("CANCEL"),
              onPressed: () {
                //pop that modal route
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                // route to ur next page
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => NewPage()));
              },
            ),
          ],
        );
      },
    );
  }
  Widget NewPage() {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    //else the user goes to the dialog confirmation box...so navigate them to ur last page insead of poping the last route
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => MyHomePage()),
                            (route) => false);
                  }),
            ),
            body: Center(
                child: Text(
                  "Exited With Confirmation",
                  style: TextStyle(fontSize: 30),
                ))));
  }
}
