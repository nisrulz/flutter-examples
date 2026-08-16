import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({
    super.key,
    required this.onSignin,
    required this.onLogout,
    required this.showLoading,
  });

  final VoidCallback? onSignin;
  final VoidCallback onLogout;
  final bool showLoading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign In")),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              showLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: onSignin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                      child: const Text("Sign In"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
