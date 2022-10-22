import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      );
    });
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // declarations
  bool oTurn = true;

  // 1st player is O
  List<String> displayElement = ['', '', '', '', '', '', '', '', ''];
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.indigo[900],
        body: Column(
          children: <Widget>[
            SingleChildScrollView(
              child: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Player X',
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            xScore.toString(),
                            style:
                                TextStyle(fontSize: 20.sp, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Player 0',
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            oScore.toString(),
                            style:
                                TextStyle(fontSize: 20.sp, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            /////////////////////////////////
            Expanded(
              flex: 4,
              child: GridView.builder(
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 25.0,
                            ),
                          ],
                        ),
                        child: Container(
                          color: Colors.white,
                          child: Center(
                            child: Text(
                              displayElement[index],
                              style: TextStyle(
                                color: displayElement[index] == 'O'
                                    ? Colors.red
                                    : Colors.green,
                                fontSize: 35.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              // Button for Clearing the Enter board
              // as well as Scoreboard to start allover again

              child: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: _clearScoreBoard,
                      child: const Text("Clear Score Board"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

/////////////////////////////functions
// filling the boxes when tapped with X
// or O respectively and then checking the winner function
  void _tapped(int index) {
    setState(() {
      if (oTurn && displayElement[index] == '') {
        displayElement[index] = 'O';

        filledBoxes++;
      } else if (!oTurn && displayElement[index] == '') {
        displayElement[index] = 'X';

        filledBoxes++;
      }
      oTurn = !oTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    // Checking rows
    if (displayElement[0] == displayElement[1] &&
        displayElement[0] == displayElement[2] &&
        displayElement[0] != '') {
      //  _showWinDialog(displayElement[0]);
      showWinSnackBar(displayElement[0]);
    }
    if (displayElement[3] == displayElement[4] &&
        displayElement[3] == displayElement[5] &&
        displayElement[3] != '') {
      showWinSnackBar(displayElement[3]);
    }
    if (displayElement[6] == displayElement[7] &&
        displayElement[6] == displayElement[8] &&
        displayElement[6] != '') {
      showWinSnackBar(displayElement[6]);
    }

    // Checking Column
    if (displayElement[0] == displayElement[3] &&
        displayElement[0] == displayElement[6] &&
        displayElement[0] != '') {
      showWinSnackBar(displayElement[0]);
    }
    if (displayElement[1] == displayElement[4] &&
        displayElement[1] == displayElement[7] &&
        displayElement[1] != '') {
      showWinSnackBar(displayElement[1]);
    }
    if (displayElement[2] == displayElement[5] &&
        displayElement[2] == displayElement[8] &&
        displayElement[2] != '') {
      showWinSnackBar(displayElement[2]);
    }

    // Checking Diagonal
    if (displayElement[0] == displayElement[4] &&
        displayElement[0] == displayElement[8] &&
        displayElement[0] != '') {
      showWinSnackBar(displayElement[0]);
    }
    if (displayElement[2] == displayElement[4] &&
        displayElement[2] == displayElement[6] &&
        displayElement[2] != '') {
      showWinSnackBar(displayElement[2]);
    } else if (filledBoxes == 9) {
      showDrawSnackBar();
    }
  }

  void showWinSnackBar(String winner) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 20),
        content: Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 75),
          decoration: BoxDecoration(
              border: Border.all(width: 2.0, color: Colors.black),
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "\" $winner \" is Winner!!!",
              style: const TextStyle(fontSize: 25),
            ),
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 1000,
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Play again',
          onPressed: () {
            _clearBoard();
          },
        ),
      ),
    );
    if (winner == 'O') {
      oScore++;
    } else if (winner == 'X') {
      xScore++;
    }
  }

  void showDrawSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 20),
        content: Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 75),
          decoration: BoxDecoration(
              border: Border.all(width: 2.0, color: Colors.black),
              borderRadius: BorderRadius.circular(20)),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Draw",
              style: TextStyle(fontSize: 25),
            ),
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 1000,
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Play again',
          onPressed: () {
            _clearBoard();
          },
        ),
      ),
    );
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayElement[i] = '';
      }
    });

    filledBoxes = 0;
  }

  void _clearScoreBoard() {
    setState(() {
      xScore = 0;
      oScore = 0;
      for (int i = 0; i < 9; i++) {
        displayElement[i] = '';
      }
    });
    filledBoxes = 0;
  }
}
