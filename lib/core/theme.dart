import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  primaryColor: Colors.deepOrange,
  primaryColorLight: Colors.deepOrange[200],
  primaryColorDark: Colors.deepOrange[800],
  accentColor: Colors.grey[850],
  colorScheme: ColorScheme(
    background: Colors.grey[100],
    brightness: Brightness.light,
    error: Colors.red,
    onBackground: Colors.grey[800],
    onError: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.grey[850],
    primary: Colors.deepOrange,
    primaryVariant: Colors.deepOrange[900],
    secondary: Colors.grey[850],
    secondaryVariant: Colors.grey[900],
    surface: Colors.white,
  ),
  cursorColor: Colors.deepOrange[600],
  scaffoldBackgroundColor: Colors.grey[100],
  textSelectionColor: Colors.deepOrange[300],
  textSelectionHandleColor: Colors.deepOrange[600],
  visualDensity: VisualDensity.comfortable,
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  appBarTheme: AppBarTheme(
    elevation: 0.5,
    color: Colors.blue[100],
    centerTitle: true,
    iconTheme: IconThemeData(color: Colors.deepOrange),
    textTheme: TextTheme(
      headline6: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.grey[850],
      ),
    ),
  ),
  bottomAppBarTheme: BottomAppBarTheme(
    color: Colors.grey[50],
  ),
  inputDecorationTheme: InputDecorationTheme(
    isDense: true,
    filled: true,
    border: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[200]),
      borderRadius: BorderRadius.circular(10),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[200]),
      borderRadius: BorderRadius.circular(10),
    ),
    disabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[200]),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[200]),
      borderRadius: BorderRadius.circular(10),
    ),
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.red[600]),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.red[600]),
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  snackBarTheme: SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.grey[850],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  popupMenuTheme: PopupMenuThemeData(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  tooltipTheme: TooltipThemeData(
    showDuration: const Duration(seconds: 5),
    preferBelow: false,
    padding: const EdgeInsets.symmetric(
      vertical: 8,
      horizontal: 12,
    ),
    decoration: BoxDecoration(
      color: Colors.black.withOpacity(.8),
      borderRadius: BorderRadius.circular(20),
    ),
  ),
);
