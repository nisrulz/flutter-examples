import 'package:flutter/material.dart';
import 'package:login_flow/login_view_model.dart';
import 'package:provider/provider.dart';

class DashboardPageWidget extends StatefulWidget {
  @override
  _DashboardPageWidgetState createState() => _DashboardPageWidgetState();
}

class _DashboardPageWidgetState extends State<DashboardPageWidget> {
  @override
  Widget build(BuildContext context) {
    final LoginViewModel _loginVM = Provider.of<LoginViewModel>(context);
    return Scaffold(
      body: Container(
        color: Colors.lightBlue,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Dashboard'),
            SizedBox(
              height: 30.0,
            ),
            FlatButton(
              color: Colors.yellow,
              onPressed: () {
                _loginVM.setIsLoggedInToApp(false);
              },
              child: Text('LOGOUT'),
            ),
          ],
        ),
      ),
    );
  }
}
