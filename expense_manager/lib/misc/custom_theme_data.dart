import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'colors.dart';

class CustomThemeData {
  static const _defaultFontSize = 14.0;
  static const _defaultTextHeight = 1.5;

  final String? fontFamily;

  final _iconTheme = IconThemeData(
    color: Colors.black,
  );

  /// for cursor iOS
  final _cupertinoOverrideTheme = CupertinoThemeData(
    primaryColor: Colors.black,
  );

  final _textTheme = TextTheme(
    bodyLarge: TextStyle(
      fontSize: _defaultFontSize,
      height: _defaultTextHeight,
    ),
    bodyMedium: TextStyle(
      fontSize: _defaultFontSize,
      height: _defaultTextHeight,
    ),
    displayLarge: TextStyle(fontWeight: FontWeight.bold),
    displayMedium: TextStyle(fontWeight: FontWeight.bold),
    displaySmall: TextStyle(fontWeight: FontWeight.bold),
    headlineMedium: TextStyle(fontWeight: FontWeight.bold),
    headlineSmall: TextStyle(fontWeight: FontWeight.bold),
    titleLarge: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 19,
    ),
  );

  final _bottomNavigationBarTheme = BottomNavigationBarThemeData(
    selectedItemColor: Colors.green,
  );

  final _dialogTheme = DialogTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  );

  final _cardTheme = CardTheme(
    elevation: 3,
    surfaceTintColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );

  final _appBarTheme = AppBarTheme(
    elevation: 0,
    foregroundColor: Colors.white,
  );

  final listTileTheme = ListTileThemeData(
    contentPadding: EdgeInsets.symmetric(horizontal: 16),
  );

  CustomThemeData({
    this.fontFamily,
  });

  ThemeData get theme => ThemeData(
        useMaterial3: true,
        fontFamily: fontFamily, // change font family eg. "OpenSans"
        primaryColor: CustomColors.primary,
        primaryColorDark: CustomColors.primaryLight,
        iconTheme: _iconTheme,
        cupertinoOverrideTheme: _cupertinoOverrideTheme,
        textTheme: _textTheme,
        appBarTheme: _appBarTheme,
        bottomNavigationBarTheme: _bottomNavigationBarTheme,
        dialogTheme: _dialogTheme,
        cardTheme: _cardTheme,
        listTileTheme: listTileTheme,
      );

  ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      primaryColor: CustomColors.primary,
      primaryColorDark: CustomColors.primaryLight,
      iconTheme: _iconTheme.copyWith(
        color: Colors.white,
      ),
      cupertinoOverrideTheme: _cupertinoOverrideTheme,
      textTheme: _textTheme,
      appBarTheme: _appBarTheme,
      bottomNavigationBarTheme: _bottomNavigationBarTheme,
      dialogTheme: _dialogTheme,
      cardTheme: _cardTheme,
      listTileTheme: listTileTheme,
    );
  }
}
