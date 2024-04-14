import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

final ThemeData customTheme = ThemeData(
  // Define colors
  primaryColor: Color(0xFF5AC7F0), //main blue
  primaryColorLight: Color(0xFFC7E7F3), //light blue
  primaryColorDark: Color(0xFF113143), //dark blue
  scaffoldBackgroundColor: Colors.white,

  // Define typography
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontFamily: "Roboto",
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: Color(0xFF113143)
    ),
    displayMedium: TextStyle(
      fontFamily: "Roboto",
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: Color(0xFF113143),
    ),
    displaySmall: TextStyle(
      fontFamily: "Roboto",
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Color(0xFF113143),
    ),
    bodyLarge: TextStyle(
     fontFamily: "Roboto",
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Color(0xFF113143),
    ),
    bodyMedium: TextStyle(
        fontFamily: "Roboto",
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xFF113143),
    ),
    labelLarge: TextStyle( //for buttons
      fontSize: 14,
      fontWeight: FontWeight.bold,
      fontFamily: 'Roboto',
      color: Colors.white,
    ),
  ),

  focusColor: Color(0xFF5AC7F0),

  // Define button theme
  buttonTheme: ButtonThemeData(
    buttonColor: Color(0xFF5AC7F0),
    textTheme: ButtonTextTheme.normal,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),

 
  // Define card theme
  cardTheme: CardTheme(
    color: Colors.white,
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),

  // Define dialog theme
  dialogTheme: DialogTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),

  // Define text button theme
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(Colors.blue),
    ),
  ),

  // Define elevated button theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Color(0xFF5AC7F0)),
      foregroundColor: MaterialStateProperty.all(Colors.white),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  ),

  // Define outlined button theme
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      side: MaterialStateProperty.all(
        BorderSide(color: Colors.blue),
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  ),

inputDecorationTheme: InputDecorationTheme(
  labelStyle: TextStyle(
    decorationColor: Color(0xFF113143)
  ),
  floatingLabelStyle: TextStyle(
    decorationColor: Color(0xFF113143)
  ),
  helperStyle: TextStyle(
    decorationColor: Color(0xFF113143)
  ),
  errorStyle: TextStyle(
    decorationColor: Colors.red
  ),
  hintStyle: TextStyle(
    decorationColor: Color(0xFF113143)
  ),
   focusedErrorBorder: UnderlineInputBorder(
      borderSide: BorderSide(width: 1.0, color: Colors.red)),
  focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(width: 1.0, color: Color(0xFF5AC7F0))),
  enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(width: 1.0, color: Color(0xFF113143))),
  border: UnderlineInputBorder(
      borderSide: BorderSide(width: 1.0, color: Color(0xFF113143))),
  disabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(width: 1.0, color: Colors.grey)),

),

  // Define switch theme
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.white; // White color for the thumb when the switch is on
      }

      return Colors.grey; // Grey color for the thumb when the switch is off
    }),

    trackColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return Color(0xFF5AC7F0); // White color for the track(bg) when the switch is on
      }

      return Color.fromARGB(255, 211, 211, 211); // Grey color for the track (bg) when the switch is off
    }),
    overlayColor: MaterialStateProperty.all(Colors.blue.withOpacity(0.1)),
  ),
);
