import 'package:flutter/material.dart';
import 'package:todo_application/themes/theme.dart';

class ThemeProvider with ChangeNotifier{

  bool isDarkMode = false ;

  ThemeData get currentTheme => isDarkMode? darkMode : lightMode ;

  void toggleTheme(){
    isDarkMode = !isDarkMode ;
    notifyListeners();
  }

}