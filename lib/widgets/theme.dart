import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData tema1() {
  return ThemeData(
    // Color Base
    scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
    primaryColor: const Color.fromARGB(5, 0, 136, 255),
    // Color de la Barra de la App
    appBarTheme: AppBarTheme(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      titleTextStyle: GoogleFonts.lato(
        color: const Color.fromARGB(255, 0, 0, 0),
        fontSize: 20.0,
      ),
    ),
    // Color de los Textos
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
        color: Color.fromARGB(255, 108, 108, 108),
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
    ),
    // Color de los Botones de MainScreen
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.amberAccent,
        foregroundColor: Colors.black,
      ),
    ),
  );
}
