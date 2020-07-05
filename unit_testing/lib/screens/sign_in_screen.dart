import 'package:flutter/material.dart';
import 'package:unit_testing/helpers.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Icon(
                Icons.account_circle,
                size: 200,
              ),
              SizedBox(
                height: 50,
              ),
              TextFormField(
                validator: (value) => FormValidator.validateEmail(value),
                decoration: InputDecoration(
                  hintText: "Email",
                ),
              ),
              SizedBox(
                height: 50,
              ),
              TextFormField(
                validator: (value) => FormValidator.validatePassword(value),
                decoration: InputDecoration(
                  hintText: "Password",
                ),
              ),
              SizedBox(
                height: 50,
              ),
              RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Navigator.of(context).pushReplacementNamed('/homeScreen');
                  }
                },
                child: Text('Sign In'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
