import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:login_flow/focused_textfield_widget.dart';
import 'package:login_flow/signup_page.dart';

class LoginPageWidget extends StatefulWidget {
  @override
  _LoginPageWidgetState createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  final FocusNode _emailNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();
  static GlobalKey<FormState> _emailFormKey = new GlobalKey<FormState>();
  static GlobalKey<FormState> _passwordFormKey = new GlobalKey<FormState>();

  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    _emailNode.addListener(_emailfocusListener);
    _passwordNode.addListener(_passwordfocusListener);
  }

  @override
  void dispose() {
    _emailNode.removeListener(_emailfocusListener);
    _passwordNode.removeListener(_passwordfocusListener);
    super.dispose();
  }

  _emailfocusListener() {
    setState(() {});
  }

  _passwordfocusListener() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final _focusScope = FocusScope.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Image.asset(
                          'images/water_splash.png',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Login',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 34.0,
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          height: 45.0,
                        ),
                        FocusedTextfieldWidget(
                          formKey: _emailFormKey,
                          focusedNode: _emailNode,
                          textController: _emailTextEditingController,
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.email),
                          onFieldSubmitted: (_) =>
                              _focusScope.requestFocus(_passwordNode),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        FocusedTextfieldWidget(
                          formKey: _passwordFormKey,
                          focusedNode: _passwordNode,
                          textController: _passwordTextEditingController,
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                          obscureText: true,
                          onFieldSubmitted: (_) => _focusScope.unfocus(),
                        ),
                        SizedBox(
                          height: 45.0,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: FlatButton(
                            shape: StadiumBorder(),
                            onPressed: () {
                              //Login calls here
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 25.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.lightBlue,
                                    Colors.blue,
                                    Colors.deepPurple,
                                  ],
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'LOGIN',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 20.0,
                                        color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      text: 'Don\'t have an account ? ',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 17.0,
                          color: Colors.grey),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Sign up',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0,
                                color: Colors.lightBlue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext _context) =>
                                        SignupPageWidget(),
                                  ),
                                );
                              }),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
