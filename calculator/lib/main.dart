import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:calculator/button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var userInput = '';
  var answer = '';
  var openP = 0;

  final List<String> buttons = [
    'C',
    '( )',
    '%',
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '+/-',
    '0',
    '.',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: theme.colorScheme.primary,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.all(20),
                  child: Text(
                    userInput,
                    style: const TextStyle(fontSize: 32),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    answer,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black12),
              ),
            ),
            child: TextButton(
              onPressed: () {
                setState(() {
                  if (userInput != '') {
                    userInput = userInput.substring(0, userInput.length - 1);
                  } else {
                    userInput = '';
                  }
                  try {
                    parseInput();
                  } on Error {
                    answer = '';
                  } on Exception {
                    answer = '';
                  }
                });
              },
              child: const Icon(Icons.backspace),
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: buttons.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4),
              itemBuilder: (BuildContext context, int index) {
                // C (clear) button
                if (index == 0) {
                  return MyButton(
                    buttonTapped: () {
                      setState(() {
                        userInput = '';
                        answer = '';
                      });
                    },
                    color: Colors.white,
                    textColor: Colors.red,
                    buttonText: buttons[index],
                  );
                  // () button
                } else if (index == 1) {
                  return MyButton(
                    buttonTapped: () {
                      setState(() {
                        if (openP == 0) {
                          setState(() {
                            openP++;
                          });
                          userInput += '(';
                        } else {
                          if (isOperator(userInput[userInput.length - 1])) {
                            setState(() {
                              openP++;
                            });
                            userInput += '(';
                          } else {
                            setState(() {
                              openP--;
                            });
                            userInput += ')';
                          }
                        }
                        try {
                          parseInput();
                        } on Error {
                          answer = '';
                        } on Exception {
                          answer = '';
                        }
                      });
                    },
                    color: theme.colorScheme.secondary,
                    textColor: Colors.white,
                    buttonText: buttons[index],
                  );
                  //+/- button
                } else if (index == 16) {
                  return MyButton(
                    buttonTapped: () {
                      setState(() {
                        for (int i = userInput.length - 1; i >= 0; i--) {
                          if (isOperator(userInput[i])) {
                            userInput =
                                '${userInput.substring(0, i + 1)}-${userInput.substring(i + 1, userInput.length)}';
                            userInput = userInput.replaceAll('--', '+');
                            userInput = userInput.replaceAll('-+', '-');
                            userInput = userInput.replaceAll('+-', '-');
                            break;
                          } else if (i == 0) {
                            userInput = '-$userInput';
                          }
                        }
                        parseInput();
                      });
                    },
                    color: Colors.white,
                    textColor: theme.colorScheme.primary,
                    buttonText: buttons[index],
                  );
                  // = button
                } else if (index == 19) {
                  return MyButton(
                    buttonTapped: () {
                      setState(() {
                        userInput = answer;
                        answer = '';
                      });
                    },
                    color: theme.colorScheme.primary,
                    textColor: Colors.white,
                    buttonText: buttons[index],
                  );
                } else {
                  return MyButton(
                    buttonTapped: () {
                      setState(() {
                        userInput += buttons[index];
                        try {
                          parseInput();
                        } on Error {
                          answer = '';
                        } on Exception {
                          answer = '';
                        }
                      });
                    },
                    color: isOperator(buttons[index])
                        ? theme.colorScheme.secondary
                        : Colors.white,
                    textColor: isOperator(buttons[index])
                        ? Colors.white
                        : theme.colorScheme.primary,
                    buttonText: buttons[index],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String label) {
    return label == '/' ||
        label == 'x' ||
        label == '-' ||
        label == '+' ||
        label == '=' ||
        label == '(' ||
        label == '%';
  }

  void parseInput() {
    String finalInput = userInput.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(finalInput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
  }
}
