import 'package:flutter/material.dart';


CustomTheme currentTheme = CustomTheme();

class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = true;
  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }
  static ThemeData get lightTheme { //1
    return ThemeData( //2
        primaryColor: Colors.purple,
        scaffoldBackgroundColor: Colors.white,
        // fontFamily: 'Montserrat', //3
        buttonTheme: ButtonThemeData( // 4
          buttonColor: Colors.teal,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        )
    );
  }
  static ThemeData get darkTheme {
    return ThemeData(
        primaryColor: Colors.black38,
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'Montserrat',
        textTheme: ThemeData.dark().textTheme,
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          buttonColor: Colors.purpleAccent,
        )
    );
  }
}