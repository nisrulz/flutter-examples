
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_google_authentication/Screens/InfoPage.dart';
import 'package:firebase_google_authentication/Screens/SignUpPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.connectionState ==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          else if(snapshot.hasError){
            return Center(child: Text('An error Occured!!'),);
          }else if(snapshot.hasData){
            return InfoPage();
          }else {
            return home(size, context);
          }
        }
      ),
    );
  }

  Column home(Size size, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Welcome!',
          style: GoogleFonts.lora(
            fontSize: 36,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 30,),
        SvgPicture.asset(
            'assets/login.svg',
          width: size.width*0.8,
          height: size.height*0.3,
        ),
        SizedBox(height: 60,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: size.width*0.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(29),
                child: FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 15,horizontal: 40),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage(true)));
                  },
                  child: Text('Login',
                    style: GoogleFonts.alice(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                  ),
                  color: Color(0xFF6F35A5),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15,),
        Container(
          width: size.width*0.8,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(29),
            child: FlatButton(
              padding: EdgeInsets.symmetric(vertical: 15,horizontal: 40),
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=> SignUpPage(false))
                );
              },
              child: Text('SignUp',
                style: GoogleFonts.alice(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),
              ),
              color: Color(0xFFF1E6FF),
            ),
          ),
        ),
      ],
    );
  }
}
