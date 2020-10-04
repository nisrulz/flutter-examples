import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_provider/theme_provider.dart';

class DarkModeTest extends StatefulWidget {
  @override
  _DarkModeTestState createState() => _DarkModeTestState();
}

class _DarkModeTestState extends State<DarkModeTest> {
  int radiovalue = 0;
  void radioValue(int val) {
    setState(() {
      radiovalue = val;
    });
  }

  saveDarkMode(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isUserNew', false);
    prefs.setInt('radiovalue', value);
  }

  void _checkUserisNew() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      dynamic result = prefs.getBool('isUserNew');
      if (result != null) {
        radiovalue = prefs.getInt('radiovalue');
      } else {
        _checkDarkModeEnabled();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void _checkDarkModeEnabled() {
    radiovalue = 2;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _checkUserisNew();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeConsumer(
      child: Builder(
        builder: (themeContext) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'DarkModeTesting',
                style: TextStyle(),
              ),
            ),
            body: Container(
                child: Center(
                    child: RaisedButton.icon(
              icon: Icon(Icons.brightness_6, color: Colors.white),
              label:
                  Text('Change Theme', style: TextStyle(color: Colors.white)),
              color: Colors.greenAccent,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder: (context, setState) {
                        return Container(
                          height: 100,
                          child: AlertDialog(
                            title: Text('Choose Theme'),
                            titlePadding: EdgeInsets.all(20),
                            content: Container(
                                height: 250,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RadioListTile(
                                      title: Text('Light'),
                                      value: 0,
                                      groupValue: radiovalue,
                                      onChanged: (val) {
                                        setState(() {
                                          radiovalue = val;
                                        });
                                      },
                                      activeColor: Colors.greenAccent,
                                    ),
                                    RadioListTile(
                                      title: Text('Dark'),
                                      value: 1,
                                      groupValue: radiovalue,
                                      onChanged: (val) {
                                        setState(() {
                                          radiovalue = val;
                                        });
                                      },
                                      activeColor: Colors.greenAccent,
                                    ),
                                    RadioListTile(
                                      title: Text('System default'),
                                      value: 2,
                                      groupValue: radiovalue,
                                      onChanged: (val) {
                                        setState(() {
                                          radiovalue = val;
                                        });
                                      },
                                      activeColor: Colors.greenAccent,
                                    ),
                                    Row(
                                      children: [
                                        FlatButton(
                                          child: Text('OK'),
                                          color: Colors.greenAccent,
                                          onPressed: () {
                                            if (radiovalue == 0) {
                                              saveDarkMode(0);
                                              ThemeProvider.controllerOf(
                                                      context)
                                                  .setTheme('light');
                                              Navigator.of(context).pop();
                                            }
                                            if (radiovalue == 1) {
                                              saveDarkMode(1);
                                              ThemeProvider.controllerOf(
                                                      context)
                                                  .setTheme('dark');
                                              Navigator.of(context).pop();
                                            }
                                            if (radiovalue == 2) {
                                              var darkMode =
                                                  MediaQuery.of(context)
                                                      .platformBrightness;
                                              if (darkMode == Brightness.dark) {
                                                saveDarkMode(2);
                                                ThemeProvider.controllerOf(
                                                        context)
                                                    .setTheme('dark');
                                                Navigator.of(context).pop();
                                              } else {
                                                saveDarkMode(2);
                                                ThemeProvider.controllerOf(
                                                        context)
                                                    .setTheme('light');
                                                Navigator.of(context).pop();
                                              }
                                            }
                                          },
                                        ),
                                        FlatButton(
                                            child: Text('CANCEL'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            })
                                      ],
                                    )
                                  ],
                                )),
                          ),
                        );
                      });
                    });
              },
            ))),
          );
        },
      ),
    );
  }
}
