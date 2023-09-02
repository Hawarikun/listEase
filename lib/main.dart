import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:list_ease/constant/colors.dart';
import 'package:list_ease/pages/main_page/main_page.dart';
import 'package:list_ease/utils/multi_provider/multiprovider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return buildAppProvider(
      MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: GoogleFonts.latoTextTheme(),
          scaffoldBackgroundColor: ColorApp.primaryColor,
          primaryColor: ColorApp.secondColor,
          // visualDensity: VisualDensity.adaptivePlatformDensity,
          useMaterial3: true,
        ),
        home: const MainPage(),
      ),
    );
  }
}
