import '../screens/home.dart';
import '../screens/countrylist.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            child: Image.asset('assets/virus.gif'),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Image.asset("assets/logo.png"),
            ),
            title: Text('Home'),
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Home()));
            },
          ),
          ListTile(
            leading: CircleAvatar(
              child: Image.asset("assets/logo.png"),
            ),
            title: Text('Affected Countries'),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => CountryList()));
            },
          ),
        ],
      ),
    );
  }
}
