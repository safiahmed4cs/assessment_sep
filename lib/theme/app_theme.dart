import 'package:flutter/material.dart';
import 'package:assessment_sep_2024/utils/color_utils.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      primarySwatch: createMaterialColor(Colors.blue),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(fontSize: 12), // Default font size is 12
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[900], // Dark blue background
          foregroundColor: Colors.white, // White text
          textStyle: const TextStyle(fontSize: 12), // Default font size is 12
        ),
      ),
      appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(
          color: Colors.blue[900], // Dark blue color
          fontWeight: FontWeight.bold, // Bold text
          fontSize: 20, // Font size for AppBar title
        ),
      ),
    );
  }
}
