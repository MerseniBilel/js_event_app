// this file contains all user's http requestes

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:js_event_app/models/user_model.dart';
import 'dart:math';

abstract class UserRepo {
  Future<void> login(String email, String password);
  Future<User> register(User user);
}

class UserService implements UserRepo {
  static const String baseUrl = "http://10.0.2.2:3033/api"; // base api url
  static const String _userEndPoint = "/users"; // the user end point

  // this is the random image avatar list
  static const List spritesOptions = [
    "male",
    "female",
    "human",
    "initials",
    "bottts",
    "avataaars",
    "jdenticon",
    "gridy",
    "micah",
    "identicon"
  ];

  // register
  @override
  Future<User> register(User user) async {
    // create an image
    //"https://avatars.dicebear.com/api/{}/{}.svg"
    Random random = Random();
    String randomChoice = spritesOptions[random.nextInt(spritesOptions.length)];
    String avatarImage =
        "https://avatars.dicebear.com/api/$randomChoice/${user.name}.svg";

    // create the body
    Object body = {
      "name": user.name,
      "lastname": user.lastname,
      "email": user.email,
      "password": user.password,
      "image": avatarImage
    };

    final header = {"Content-Type": "application/json"};

    Uri uri = Uri.https(baseUrl, _userEndPoint);
    Response response = await http.post(uri, body: body, headers: header);
    User logedInUser = userFromJson(response.body);
    return logedInUser;
  }

  // login
  @override
  Future<void> login(String email, String password) async {}
}
