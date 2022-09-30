import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeNotifer extends ChangeNotifier{
  ThemeData? _themeData;
  ThemeNotifer(this._themeData);
  ThemeData? get getTheme =>_themeData;
  
  setTheme(ThemeData themeData){
    _themeData=themeData;
    notifyListeners();
  }

}