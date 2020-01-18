import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'home.dart';
import 'user.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  AppState createState() => AppState();
}

class AppState extends State<App> {
  String _username = "";
  Widget currentPage;
  GoogleSignIn googleSignIn;
  Widget userPage;

  @override
  void initState() {
    super.initState();
    userPage = Home(
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
      userPage = Home(onSignin: null, onLogout: _logout, showLoading: true);
    });
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      googleSignIn = GoogleSignIn();
      GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication gauth = await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: gauth.accessToken,
        idToken: gauth.idToken,
      );
      final AuthResult authRes = await _auth.signInWithCredential(credential);
      final FirebaseUser user = authRes.user;

      setState(() {
        _username = user.displayName;
        userPage = User(
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
      userPage = Home(
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
    return MaterialApp(
      home: userPage,
    );
  }
}
