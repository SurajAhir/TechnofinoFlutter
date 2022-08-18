import 'dart:ui';

import 'package:flutter/material.dart';

class Styles {

  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      primarySwatch: Colors.red,
      bottomAppBarColor: isDarkTheme ? Color(0xff282525): Colors.white,
      primaryColor: isDarkTheme ? Colors.white : Colors.lightBlueAccent,

      buttonColor: isDarkTheme ? Color(0xffb1aaaa) : Color(0xffb1aaaa),
      indicatorColor: isDarkTheme ? Colors.orangeAccent : Colors.orangeAccent,
      backgroundColor: isDarkTheme ? Colors.black : Color(0xfff8f2f2),
      accentColor: isDarkTheme ? Colors.white : Colors.black,
      // fontFamily: "Schyler",

      splashColor: isDarkTheme ? Colors.black: Colors.black,

      hintColor: isDarkTheme ? Color(0xff280C0B) : Color(0xffEECED3),

      highlightColor: isDarkTheme ? Color(0xff372901) : Color(0xffFCE192),
      hoverColor: isDarkTheme ? Color(0xff3A3A3B) : Color(0xff4285F4),
      focusColor: isDarkTheme ? Colors.white : Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      cardColor: isDarkTheme ? Color(0xFF151515) : Colors.white,
      canvasColor: isDarkTheme ? Colors.white : Colors.grey[50],
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme ? ColorScheme.dark() : ColorScheme.light()),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        backgroundColor:isDarkTheme ? Colors.black: Colors.black,
      ), textSelectionTheme: TextSelectionThemeData(selectionColor: isDarkTheme ? Colors.white : Colors.black),

    );

  }
}