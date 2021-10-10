import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_google_authentication/Services/google_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  //const SignUpPage({Key? key}) : super(key: key);
  bool isLogin;
  SignUpPage(this.isLogin);
  @override
  _SignUpPageState createState() => _SignUpPageState(isLogin);
}

class _SignUpPageState extends State<SignUpPage> {
  bool isLogin;
  _SignUpPageState(this.isLogin);

  bool loggingIn = false;
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  bool showPassword = false;

  void showSnackBar() {
    final snackBar = new SnackBar(
      content: Text('Invalid Credentials!'),
      backgroundColor: Colors.red,
      padding: EdgeInsets.symmetric(horizontal: 10),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    (isLogin)?'Login':'SignUp',
                    style: GoogleFonts.alice(
                      fontWeight: FontWeight.bold,
                      fontSize: 29,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SvgPicture.asset(
                    (isLogin)?'assets/signup.svg':'assets/signup.svg',
                    width: size.width * 0.5,
                    height: size.height * 0.3,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: TextField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(29),
                        ),
                        hintText: 'Your Email',
                        filled: true,
                        fillColor: Color(0xFFF1E6FF),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color(0xFF6F35A5),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: TextField(
                      controller: password,
                      obscureText: !showPassword,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(29),
                          ),
                          hintText: 'Password',
                          filled: true,
                          fillColor: Color(0xFFF1E6FF),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Color(0xFF6F35A5),
                          ),
                          suffixIcon: showPassword
                              ? IconButton(
                            icon: Icon(
                              Icons.visibility_off,
                              color: Color(0xFF6F35A5),
                            ),
                            onPressed: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                          )
                              : IconButton(
                            icon: Icon(
                              Icons.visibility,
                              color: Color(0xFF6F35A5),
                            ),
                            onPressed: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: size.width * 0.8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(29),
                      child: FlatButton(
                        padding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                        onPressed: () {
                          String _email = email.text;
                          String _password = password.text;
                          !(isLogin)?
                          signUpClicked(_email, _password, context):
                          loginClicked(_email, _password, context);
                        },
                        child: Text(
                          (isLogin)?'Login':'SignUp',
                          style: GoogleFonts.alata(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        color: Color(0xFF6F35A5),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Container(
                    width: size.width * 0.81,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(29),
                      child: FlatButton.icon(
                        padding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                        onPressed: () {
                          final provider = Provider.of<GoogleSignInProvider>(
                              context,
                              listen: false);
                          provider.googleLogin().then((value) {
                            Navigator.popUntil(
                                context, (route) => route.isFirst);
                          }).catchError((onError) {
                            showSnackBar();
                          });
                        },
                        icon: FaIcon(
                          FontAwesomeIcons.google,
                          color: Colors.white,
                        ),
                        label: Text(
                          (isLogin)?'Login with Google':'SignUp with Google',
                          style: GoogleFonts.alata(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        color: Color(0xFF6F35A5),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        isLogin = !isLogin;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          (isLogin)?'Don\'t have an account?':'Already have an account?',
                          style: GoogleFonts.lato(
                            color: Color(0xFF6F35A5),
                          ),
                        ),
                        Text(
                          (isLogin)?'SignUp':'SignIn',
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6F35A5),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  signUpClicked(String _email, String _password, BuildContext context) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: _email, password: _password)
        .then((value) {
      setState(() {
        loggingIn = true;
      });
      Future.delayed(
          Duration(seconds: 1, milliseconds: 50), (){
        Navigator.popUntil(
            context, (route) => route.isFirst);
      });
    }).catchError((e) {
      showSnackBar();
    });
  }

  bool loginClicked(String _email, String _password, BuildContext context) {
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email, password: _password).then((value){
      setState(() {
        loggingIn = true;
      });
      Future.delayed(Duration(seconds: 1,milliseconds: 50),(){
        Navigator.pop(context);
      });
    }).catchError((e){
      showSnackBar();
    });
    return loggingIn;
  }
}
