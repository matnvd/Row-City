import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:row_city/const.dart';

import 'home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        appBarTheme: const AppBarTheme(
          backgroundColor: darkGray,
          elevation: 5.0,
          shadowColor: Colors.black,
        ),
        primaryColor: maroon,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: secondaryColor,
        ),
        scaffoldBackgroundColor: darkGray,
        useMaterial3: true,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(),
          bodyMedium: TextStyle(),
        ).apply(
          bodyColor: Colors.white,
          // displayColor: darkMain,
        ),
        tabBarTheme: const TabBarTheme(labelColor: lightMaroon),
      ),
    );
  }
}
