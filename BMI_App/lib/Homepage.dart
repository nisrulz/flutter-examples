import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bmi_app/result.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';

enum Gender { Male, Female }
Gender gender;
double bmi = 0;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color card_color = Colors.blueGrey[800];
  int height = 180;
  int weight = 70;
  int age = 20;
  Timer timer;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[800],
          centerTitle: true,
          title: Text(
            'BMI CALCULATOR',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
        ),
        drawer: Drawer(
          elevation: 10,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                padding: EdgeInsets.all(5),
                child: Image(
                  image: AssetImage('assets/bmi.png'),
                ),
              ),
              ListTile(
                  leading: Icon(Icons.info),
                  title: Text(
                    'BMI',
                    style: TextStyle(fontSize: 20),
                  ),
                  subtitle: Text('What is BMI?'),
                  onTap: () {
                    AwesomeDialog(
                      customHeader: Text(
                        'BMI',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.yellow),
                      ),
                      padding: EdgeInsets.all(5),
                      context: context,
                      animType: AnimType.LEFTSLIDE,
                      dialogType: DialogType.NO_HEADER,
                      body: Container(
                        child: Text(
                          '''- The body mass index (BMI) is a measure that uses your height and weight to work out if your weight is healthy.

- The BMI calculation divides an adult's weight in kilograms by their height in metres squared. For example, A BMI of 25 means 25kg/m2.''',
                          style: TextStyle(
                              fontStyle: FontStyle.italic, fontSize: 20),
                        ),
                      ),
                      btnOkOnPress: () {},
                    )..show();
                  }),
              ListTile(
                leading: Icon(Icons.insert_chart),
                title: Text(
                  'Chart',
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Text('Height -> Weight'),
                onTap: () {
                  AwesomeDialog(
                    context: context,
                    customHeader: Icon(
                      Icons.insert_chart,
                      size: 50,
                      color: Colors.pinkAccent,
                    ),
                    animType: AnimType.LEFTSLIDE,
                    dialogType: DialogType.NO_HEADER,
                    body: Image(
                      image: AssetImage('assets/bmi_chart.png'),
                    ),
                    btnOkOnPress: () {},
                  )..show();
                },
              ),
              ListTile(
                leading: Icon(Icons.perm_identity),
                title: Text(
                  'About Developer',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  AwesomeDialog(
                    context: context,
                    customHeader: CircleAvatar(
                      backgroundImage:
                      AssetImage('assets/ic_launcher.png'),
                      radius: 50,
                    ),
                    animType: AnimType.LEFTSLIDE,
                    dialogType: DialogType.NO_HEADER,
                    body: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Your Name',
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: 'Pacifico',
                                    letterSpacing: 1,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'your_email@example.com',
                                  style: TextStyle(
                                      fontSize: 15,
                                      letterSpacing: 2,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Ink(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.white54,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: RaisedButton(
                                  elevation: 20,
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  color: Colors.white,
                                  child: Icon(
                                    FontAwesomeIcons.github,
                                    color: Colors.black,
                                    size: 28,
                                  ),
                                  onPressed: () {
                                    launch('https://github.com/mrflame20');
                                  }),
                            ),
                            Ink(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.white54,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: RaisedButton(
                                  elevation: 20,
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  color: Colors.white,
                                  child: Icon(
                                    FontAwesomeIcons.linkedinIn,
                                    color: Colors.blue,
                                    size: 28,
                                  ),
                                  onPressed: () {
                                    launch(
                                        'https://www.linkedin.com/');
                                  }),
                            ),
                          ],
                        ),
                      ],
                    ),
                    btnOkOnPress: () {},
                  )..show();
                },
              ),
            ],
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: Card_bmi(
                      onPressed: () {
                        setState(() {
                          gender = Gender.Male;
                        });
                      },
                      card_color: gender == Gender.Male
                          ? Colors.blueGrey[600]
                          : card_color,
                      card_child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.mars,
                            size: 120,
                            color: Colors.blue,
                          ),
                          Text(
                            'MALE',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[100],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card_bmi(
                      onPressed: () {
                        setState(() {
                          gender = Gender.Female;
                        });
                      },
                      card_color: gender == Gender.Female
                          ? Colors.blueGrey[600]
                          : card_color,
                      card_child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.venus,
                            size: 120,
                            color: Colors.pinkAccent,
                          ),
                          Text(
                            'FEMALE',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink[300],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Card_bmi(
                card_color: card_color,
                card_child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'HEIGHT',
                      style:
                      TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Text(
                          height.toString(),
                          style: TextStyle(
                              fontSize: 55, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'cm',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          feetInch(height),
                          style: TextStyle(
                              fontSize: 55, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Slider(
                        min: 123,
                        max: 220,
                        value: height.toDouble(),
                        activeColor:
                        gender == Gender.Male ? Colors.blue : Colors.pink,
                        inactiveColor: Colors.white,
                        onChanged: (double value) {
                          setState(() {
                            height = value.round();
                          });
                        }),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: Card_bmi(
                      card_color: card_color,
                      card_child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            'WEIGHT(kg)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.yellow,
                            ),
                          ),
                          Text(
                            weight.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 60),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              RawMaterialButton(
                                child: GestureDetector(
                                    child: Icon(FontAwesomeIcons.minus),
                                    onTapDown: (TapDownDetails details) {
                                      setState(() {
                                        timer = Timer.periodic(
                                            Duration(milliseconds: 200), (t) {
                                          setState(() {
                                            weight--;
                                          });
                                        });
                                      });
                                    },
                                    onTapCancel: () {
                                      timer.cancel();
                                    },
                                    onTapUp: (TapUpDetails details) {
                                      timer.cancel();
                                    }),
                                onPressed: () {
                                  weight--;
                                },
                                shape: CircleBorder(),
                                fillColor: Colors.grey[600],
                                elevation: 6,
                                constraints: BoxConstraints.tightFor(
                                    height: 50, width: 50),
                              ),
                              RawMaterialButton(
                                child: GestureDetector(
                                    child: Icon(FontAwesomeIcons.plus),
                                    onTapDown: (TapDownDetails details) {
                                      setState(() {
                                        timer = Timer.periodic(
                                            Duration(milliseconds: 200), (t) {
                                          setState(() {
                                            weight++;
                                          });
                                        });
                                      });
                                    },
                                    onTapCancel: () {
                                      timer.cancel();
                                    },
                                    onTapUp: (TapUpDetails details) {
                                      timer.cancel();
                                    }),
                                onPressed: () {
                                  setState(() {
                                    weight++;
                                  });
                                },
                                shape: CircleBorder(),
                                fillColor: Colors.grey[600],
                                elevation: 6,
                                constraints: BoxConstraints.tightFor(
                                    height: 50, width: 50),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card_bmi(
                      card_color: card_color,
                      card_child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            'AGE',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.yellow,
                            ),
                          ),
                          Text(
                            age.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 60),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              RawMaterialButton(
                                child: GestureDetector(
                                    child: Icon(FontAwesomeIcons.minus),
                                    onTapDown: (TapDownDetails details) {
                                      setState(() {
                                        timer = Timer.periodic(
                                            Duration(milliseconds: 200), (t) {
                                          setState(() {
                                            age--;
                                          });
                                        });
                                      });
                                    },
                                    onTapCancel: () {
                                      timer.cancel();
                                    },
                                    onTapUp: (TapUpDetails details) {
                                      timer.cancel();
                                    }),
                                onPressed: () {
                                  setState(() {
                                    age--;
                                  });
                                },
                                shape: CircleBorder(),
                                fillColor: Colors.grey[600],
                                elevation: 6,
                                constraints: BoxConstraints.tightFor(
                                    height: 50, width: 50),
                              ),
                              RawMaterialButton(
                                child: GestureDetector(
                                    child: Icon(FontAwesomeIcons.plus),
                                    onTapDown: (TapDownDetails details) {
                                      setState(() {
                                        timer = Timer.periodic(
                                            Duration(milliseconds: 200), (t) {
                                          setState(() {
                                            age++;
                                          });
                                        });
                                      });
                                    },
                                    onTap: () {
                                      setState(() {
                                        age++;
                                      });
                                    },
                                    onTapCancel: () {
                                      timer.cancel();
                                    },
                                    onTapUp: (TapUpDetails details) {
                                      timer.cancel();
                                    }),
                                onPressed: () {
                                  setState(() {
                                    age++;
                                  });
                                },
                                shape: CircleBorder(),
                                fillColor: Colors.grey[600],
                                elevation: 6,
                                constraints: BoxConstraints.tightFor(
                                    height: 50, width: 50),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => result()));
                setState(() {
                  bmi = weight / pow(height / 100, 2);
                });
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: gender == Gender.Male ? Colors.blue : Colors.pink,
                ),
                child: Text(
                  'CALCULATE',
                  style: TextStyle(
                      fontSize: 35,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class Card_bmi extends StatelessWidget {
  final Color card_color;
  final Widget card_child;
  final Function onPressed;

  Card_bmi(
      {@required this.card_child, @required this.card_color, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        child: card_child,
        margin: EdgeInsets.all(13),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: card_color,
        ),
      ),
    );
  }
}

String feetInch(int h) {
  double feet;
  double inch;
  String f, i;
  inch = h * 0.3937;
  feet = (inch * 0.083).floorToDouble();
  inch = (inch - (12 * feet.floorToDouble()));
  f = feet.toStringAsFixed(0);
  i = inch.toStringAsFixed(0);

  return ('''/$f'$i" ''');
}
