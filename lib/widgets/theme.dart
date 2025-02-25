import 'package:flutter/material.dart';

ThemeData tema1() {
  return ThemeData(
    // Color Base
    scaffoldBackgroundColor: Color.fromARGB(255, 0, 98, 255),
    primaryColor: const Color.fromARGB(5, 0, 136, 255),
    // Color de la Barra de la App
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 0, 98, 255),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    // Color de los Textos
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
        color: Colors.yellowAccent,
        fontWeight: FontWeight.bold,
        fontSize: 16.0,
      ),
      // Texto informativo
      bodyMedium: TextStyle(
        color: Color.fromARGB(255, 164, 214, 219),
        fontWeight: FontWeight.bold,
        fontSize: 16.0,
      ),
      bodySmall: TextStyle(
        color: Color.fromARGB(100, 0, 50, 255),
        fontWeight: FontWeight.bold,
        fontSize: 14.0,
      ),
    )
  );
}