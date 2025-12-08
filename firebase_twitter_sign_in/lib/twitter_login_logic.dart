import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart';

Future<void> signInWithTwitter(BuildContext context) async {
  try {
    final twitterAuthProvider = TwitterAuthProvider();

    final UserCredential userCredential = await FirebaseAuth.instance
        .signInWithProvider(twitterAuthProvider);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Logged in as ${userCredential.user?.displayName}'),
      ),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  } catch (e) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Login failed: $e')));
  }
}
