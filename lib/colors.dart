
import 'package:flutter/material.dart';

ThemeData? activeTheme;
final darkTheme=ThemeData(
  textTheme: TextTheme(bodyText2: TextStyle(color: Colors.white)),
  iconTheme: IconThemeData(color: Colors.white),
  cardColor: Colors.black,
  primaryColor: Colors.black,
  primarySwatch: Colors.grey,

  accentColor: Colors.grey,
  brightness: Brightness.dark,
  backgroundColor: Colors.black,
  accentIconTheme: IconThemeData(color: Colors.black),



);
final lightTheme=ThemeData(
  textTheme: TextTheme(bodyText2: TextStyle(color: Colors.white)),
  iconTheme: IconThemeData(color: Colors.white),
  cardColor: Colors.grey,
  primaryColor: Colors.grey,
  primarySwatch: Colors.grey,

  accentColor: Colors.black,
  brightness: Brightness.light,
  backgroundColor: Colors.black,
  accentIconTheme: IconThemeData(color: Colors.black),

);
final greenTheme=ThemeData(
  textTheme: TextTheme(bodyText2: TextStyle(color: Colors.black),),

  appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: Colors.white,),
  textTheme: TextTheme(bodyText2: TextStyle(color: Colors.white)
  )),
  iconTheme: IconThemeData(color: Colors.white),
  cardColor: Colors.green[500],
  primaryColor: Colors.green,
  primarySwatch: Colors.green,
  accentColor: Colors.green,
  brightness: Brightness.light,
  backgroundColor: Colors.green,
  radioTheme: RadioThemeData(
    fillColor: MaterialStateColor.resolveWith((states) => Colors.green,),),
  accentIconTheme: IconThemeData(color: Colors.green),


);
final blueTheme=ThemeData(
  textTheme: TextTheme(bodyText2: TextStyle(color: Colors.white)),
  iconTheme: IconThemeData(color: Colors.white),
  cardColor: Colors.blue[500],
  primaryColor: Colors.blue,
  primarySwatch: Colors.blue,

  accentColor: Colors.blue,
  brightness: Brightness.light,
  backgroundColor: Colors.blue,
  accentIconTheme: IconThemeData(color: Colors.blue),


);
