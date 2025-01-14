import 'package:flutter/material.dart';
import 'conversion_page.dart'; // Import the ConversionPage class

class UnitConversionApp extends StatefulWidget {
  const UnitConversionApp({super.key});

  @override
  _UnitConversionAppState createState() => _UnitConversionAppState();
}

class _UnitConversionAppState extends State<UnitConversionApp> {
  MaterialColor _themeColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Unit Converter',
      theme: ThemeData(
        primarySwatch: _themeColor,
        scaffoldBackgroundColor: _themeColor.shade100,
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            fontSize: 18,
            color: _themeColor.shade900,
            fontFamily: 'Roboto',
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            color: _themeColor.shade900,
            fontFamily: 'Roboto',
          ),
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: _themeColor.shade900,
            fontFamily: 'Roboto',
          ),
        ),
      ),
      home: ConversionPage(
        onThemeChanged: (color) {
          setState(() {
            _themeColor = color;
          });
        },
      ),
    );
  }
}
