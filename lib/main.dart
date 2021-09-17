import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:js_event_app/screens/onboarding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Js event app',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: GoogleFonts.sora().fontFamily,
        ),
        home: const OnBoarding());
  }
}
