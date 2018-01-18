import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(home: new MyDrawerApp()));
}

class MyDrawerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var headerChild = new DrawerHeader(child: new Text("Header"));
    var aboutChild = new AboutListTile(
        child: new Text("About"),
        applicationName: "Application Name",
        applicationVersion: "v1.0.0",
        applicationIcon: new Icon(Icons.adb),
        icon: new Icon(Icons.info));

    var myNavChildren = [
      headerChild,
      getNavItem(Icons.settings, "Settings"),
      getNavItem(Icons.call, "Call"),
      getNavItem(Icons.home, "Home"),
      getNavItem(Icons.account_box, "Account"),
      aboutChild
    ];

    ListView listView = new ListView(children: myNavChildren);
    Drawer myDrawer = new Drawer(
      child: listView,
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Navigation Drawer Example"),
      ),
      body: new Container(
          child: new Center(
        child: new Text("Hello World!"),
      )),
      drawer: myDrawer,
    );
  }

  ListTile getNavItem(var icon, String s) {
    return new ListTile(
      leading: new Icon(icon),
      title: new Text(s),
    );
  }
}
