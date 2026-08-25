import 'package:flutter/material.dart';
import 'package:login_flow/dashboard_page.dart';
import 'package:login_flow/loading_page.dart';
import 'package:login_flow/login_page.dart';
import 'package:login_flow/login_view_model.dart';
import 'package:login_flow/signup_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginViewModel>(
            create: (BuildContext context) => LoginViewModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final LoginViewModel _loginVM = Provider.of<LoginViewModel>(context);

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPageWidget(),
      // home: FutureBuilder<bool>(
      //   future: _loginVM.isLoggedInToApp(),
      //   builder: (BuildContext buildContext, AsyncSnapshot<bool> snap) {
      //     print("_loginVM ${snap.data}");
      //     if (snap.connectionState == ConnectionState.waiting) {
      //       return LoadingPageWidget();
      //     } else if (snap.data == false || snap.data == null) {
      //       return LoginPageWidget();
      //     } else {
      //       return DashboardPageWidget();
      //     }
      //   },
      // ),
    );
  }
}
