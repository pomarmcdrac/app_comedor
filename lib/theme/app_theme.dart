import 'package:flutter/material.dart';

class AppTheme {

  static const Color primary = Color.fromRGBO(65, 182, 230, 1);//#41B6E6
  static const Color secondary = Color.fromRGBO(159, 193, 67, 1);//#9FC143
  static const Color blanco = Color.fromRGBO(255, 255, 255, 1);//#FFFFFF
  static const Color amarillo = Color.fromRGBO(255, 195, 0, 1);//#FFC300
  static const Color rosa = Color.fromRGBO(230, 0, 129, 1);//#E60081
  static const Color azulOscuro = Color.fromRGBO(0, 94, 141, 1);//#005E8D

  static final ThemeData lightTheme = ThemeData.dark().copyWith(
    //Color primario
    primaryColor: primary,

    //Color secundario
    secondaryHeaderColor: secondary,

    //AppBar Theme
    appBarTheme: const AppBarTheme(
      color: primary,
      elevation: 0
    ),

    //TextButton Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: primary),
    ),

    //FloatingActionButtons Theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primary,
      elevation: 2,
    ),

    //ElevatedButtons Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary, 
        shape: const StadiumBorder(), 
        elevation: 1
      ),
    ),

    inputDecorationTheme: const InputDecorationTheme(
      floatingLabelStyle: TextStyle( color: primary ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide( color: primary),
        borderRadius: BorderRadius.only( bottomLeft: Radius.circular(10), topRight: Radius.circular(10))
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide( color: primary),
        borderRadius: BorderRadius.only( bottomLeft: Radius.circular(10), topRight: Radius.circular(10))
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.only( bottomLeft: Radius.circular(10), topRight: Radius.circular(10))
      )
    )
  );
}
