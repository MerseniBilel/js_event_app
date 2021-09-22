import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:js_event_app/models/user_model.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    User logedInUser = args['logedUser'];
    return Scaffold(
      body: Center(
        child: Text(
          logedInUser.email,
          style: const TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
