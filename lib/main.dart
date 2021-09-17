import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:js_event_app/screens/home_screen.dart';
import 'package:js_event_app/screens/login_screen.dart';
import 'package:js_event_app/screens/onboarding.dart';
import 'package:js_event_app/screens/register_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.transparent,
  ));
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
        home: const OnBoarding(),
        routes: {
          "login": (context) => const Login(),
          "register": (context) => const Register(),
          "home": (context) => const Home(),
        });
  }
}
