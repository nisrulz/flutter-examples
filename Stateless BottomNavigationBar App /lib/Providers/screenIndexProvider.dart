import 'package:flutter/material.dart';

class screenIndexProvider extends ChangeNotifier {
  int screenIndex = 0; // Initial index of the screen
  int get fetchCurrentScreenIndex {
    // function to return the current screen Index
    return screenIndex;
  }

  void updateScreenIndex(int newIndex) {
    // function to update the screenIndex
    screenIndex = newIndex;
    notifyListeners(); // This will notify every listeners that the screen index has been changed
  }
}
