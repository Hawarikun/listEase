import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:list_ease/constant/colors.dart';
import 'package:list_ease/pages/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(),
        scaffoldBackgroundColor: ColorApp.primaryColor,
        primaryColor: ColorApp.secondColor,
        // visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}
