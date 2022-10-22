import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_google_authentication/Services/google_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(onPressed: (){
                  final provider = Provider.of<GoogleSignInProvider>(
                      context,
                      listen: false);
                  provider.googleLogout();
                },
                    child: Text('Logout',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    )),
              ],
            ),
            SizedBox(height: 200,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                    user!.photoURL??'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'
                  ),
                ),
                SizedBox(height: 15,),
                Text(user!.email??'',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
