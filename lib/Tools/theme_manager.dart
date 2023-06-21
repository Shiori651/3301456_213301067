import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(brightness: Brightness.light);
ThemeData darkTheme = ThemeData(brightness: Brightness.dark);

class ThemeManager with ChangeNotifier {
  ThemeMode _thememode = ThemeMode.dark;

  ThemeMode get themeMode => _thememode;

  // ignore: inference_failure_on_function_return_type, always_declare_return_types, avoid_positional_boolean_parameters, type_annotate_public_apis
  toggletheme(bool darkmode) {
    _thememode = darkmode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
