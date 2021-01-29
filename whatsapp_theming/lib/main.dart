import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'darkmode.dart';
import 'package:flutter/cupertino.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:flutter/scheduler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int radiovalue;
  loadRadiovalue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic result = prefs.getInt('radiovalue');
    if (result != null) {
      return result;
    } else {
      return 2;
    }
  }

  @override
  void initState() {
    loadRadiovalue().then((val) {
      setState(() {
        radiovalue = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      themes: [
        AppTheme.light(id: 'light'),
        AppTheme.dark(id: 'dark'),
      ],
      saveThemesOnChange: true,
      loadThemeOnInit: false,
      onInitCallback: (controller, previouslySavedThemeFuture) async {
        String savedTheme = await previouslySavedThemeFuture;

        if (savedTheme != null && radiovalue == 2) {
          Brightness platformBrightness =
              SchedulerBinding.instance.window.platformBrightness;
          if (platformBrightness == Brightness.dark) {
            controller.setTheme('dark');
          } else {
            controller.setTheme('light');
          }
          controller.forgetSavedTheme();
        } else if (radiovalue != 2 && savedTheme != null) {
          controller.setTheme(savedTheme);
        } else {
          Brightness platformBrightness =
              SchedulerBinding.instance.window.platformBrightness;
          if (platformBrightness == Brightness.dark) {
            controller.setTheme('dark');
          } else {
            controller.setTheme('light');
          }
          controller.forgetSavedTheme();
        }
      },
      child: ThemeConsumer(child: Builder(builder: (themeContext) {
        return new MaterialApp(
          theme: ThemeProvider.themeOf(themeContext).data,
          home: new DarkModeTest(),
        );
      })),
    );
  }
}
