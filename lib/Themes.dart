import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {

  static bool tempIsDark = false;

  ThemeProvider({required bool isDarkMode}) {
    tempIsDark = true;
  }
  ThemeMode themeMode = tempIsDark == true ? ThemeMode.dark : ThemeMode.light;
  // This boolean returns true if dark mode is enabled and vice versa
  bool get isDarkMode => themeMode == ThemeMode.dark;

  // To save strings in shared preferences
  void saveBoolData(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    saveBoolData("isDarkTheme", isOn);
    notifyListeners();
  }

}

class MyThemes {
  static final darkTheme = ThemeData(
    primaryColor: Colors.white,
    scaffoldBackgroundColor: Colors.black87,
    colorScheme: ColorScheme.dark(),
    iconTheme: IconThemeData(color: Colors.redAccent),
    appBarTheme: AppBarTheme(color: Colors.blueGrey[900]),
    backgroundColor: Colors.black,
    dialogBackgroundColor: Colors.blueGrey[900],
    floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.amber[300]),
  );

  static final lightTheme = ThemeData(
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.purple[50],
    colorScheme: ColorScheme.light(),
    iconTheme: IconThemeData(color: Colors.green[800]),
    appBarTheme: AppBarTheme(color: Colors.deepPurple),
    backgroundColor: Colors.white,
    dialogBackgroundColor: Colors.white,
    floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.deepPurpleAccent),
  );
}
