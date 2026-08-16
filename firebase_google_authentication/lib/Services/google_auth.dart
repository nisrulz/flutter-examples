import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn.instance;

  GoogleSignInAccount? _user;
  User? user1;
  GoogleSignInAccount get user => _user!;
  String? userId;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future googleLogin() async {
    try {
      await googleSignIn.initialize();
      final googleUser = await googleSignIn.authenticate();
      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credentials = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credentials);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future googleLogout() async {
    try {
      print('Logging Out');
      await googleSignIn.disconnect();
      FirebaseAuth.instance.signOut();
    } catch (e) {
      FirebaseAuth.instance.signOut();
    }
    notifyListeners();
  }
}
