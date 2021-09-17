import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:js_event_app/constants.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // default styling for header text
  static const headerTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  // default padding
  static const double kDefaultPadding = 20.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          //SvgPicture.asset(
          //  "assets/img/Sign_Up_bg.svg",
          //  fit: BoxFit.fill,
          //),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Create Account",
                    style: headerTextStyle,
                  ),
                  Row(
                    children: [
                      const Text("Aleady Hava an account?"),
                      TextButton(
                        onPressed: () => print("sing in clicked"),
                        child: const Text(
                          "Sing in",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  Form(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: primaryColor),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
