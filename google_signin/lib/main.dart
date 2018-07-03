import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';
import 'user.dart';
import 'dart:async';

void main() {
  runApp(new App());
}

class App extends StatefulWidget {
  AppState createState() => new AppState();
}

class AppState extends State<App> {
  String _username = "";
  Widget currentPage;
  GoogleSignIn googleSignIn;
  Widget userPage;
  @override
  void initState() {
    super.initState();
    userPage = new Home(
      onSignin: () {
        _signin();
        print("Sign");
      },
      onLogout: _logout,
      showLoading: false,
    );
  }

  Future<FirebaseUser> _signin() async {
    setState(() {
      userPage = new Home(onSignin: null, onLogout: _logout, showLoading: true);
    });
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      googleSignIn = new GoogleSignIn();
      GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication gauth =
          await googleSignInAccount.authentication;
      FirebaseUser user = await _auth.signInWithGoogle(
        accessToken: gauth.accessToken,
        idToken: gauth.idToken,
      );

      setState(() {
        _username = user.displayName;
        userPage = new User(
          onLogout: _logout,
          user: user,
        );
      });

      return user;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  void _logout() async {
    await googleSignIn.signOut();
    setState(() {
      userPage = new Home(
        onSignin: () {
          _signin();
          print("Sign");
        },
        onLogout: _logout,
        showLoading: false,
      );
    });

    print("Logged Out");
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: userPage,
    );
  }
}
