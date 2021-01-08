import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  primaryColor: Color(0xFFFF4B00),
  accentColor: Color(0xFF0981D1),
  cardColor: Color(0xFFFAFAFA),
  scaffoldBackgroundColor: Color(0xFFFFFEFE),
  backgroundColor: Color(0xFFFFFEFE),
  unselectedWidgetColor: Color(0xFF272D2F),
  brightness: Brightness.light,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: 'SourceSansPro',
  textTheme: TextTheme(
    headline1: TextStyle(color: Color(0xFF272D2F)),
    headline2: TextStyle(color: Color(0xFF272D2F)),
    headline3: TextStyle(color: Color(0xFF272D2F)),
    headline4: TextStyle(color: Color(0xFF272D2F)),
    headline5: TextStyle(color: Color(0xFF272D2F)),
    headline6: TextStyle(color: Color(0xFF272D2F)),
    subtitle1: TextStyle(color: Color(0xFF272D2F)),
    subtitle2: TextStyle(color: Color(0xFF272D2F)),
    button: TextStyle(color: Color(0xFF272D2F)),
    caption: TextStyle(color: Color(0xFF272D2F)),
  ),
);

final darkTheme = ThemeData(
  primaryColor: Color(0xFFFF4B00),
  accentColor: Color(0xFF0981D1),
  scaffoldBackgroundColor: Colors.black,
  backgroundColor: Colors.black,
  cardColor: Color(0xFF141414),
  unselectedWidgetColor: Colors.white,
  brightness: Brightness.dark,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: 'SourceSansPro',
  textTheme: TextTheme(
    headline1: TextStyle(color: Color(0xFFFFFEFE)),
    headline2: TextStyle(color: Color(0xFFFFFEFE)),
    headline3: TextStyle(color: Color(0xFFFFFEFE)),
    headline4: TextStyle(color: Color(0xFFFFFEFE)),
    headline5: TextStyle(color: Color(0xFFFFFEFE)),
    headline6: TextStyle(color: Color(0xFFFFFEFE)),
    subtitle1: TextStyle(color: Color(0xFFFFFEFE)),
    subtitle2: TextStyle(color: Color(0xFFFFFEFE)),
    button: TextStyle(color: Color(0xFFFFFEFE)),
    caption: TextStyle(color: Color(0xFFFFFEFE)),
  ),
);
