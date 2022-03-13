import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:cookingbox_app/constants/colors.dart';
import 'package:cookingbox_app/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String appTitle = 'CookingBox';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: AppColor.primaryColor,
        backgroundColor: Colors.white,
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const HomeScreen(title: appTitle),
    );
  }
}
