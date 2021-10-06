// this file contains all user's http requestes

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:js_event_app/constants.dart';
import 'package:js_event_app/models/user_model.dart';
import 'dart:math';

abstract class UserRepo {
  Future<void> login(String email, String password);
  Future<User?> register(User user);
}

class UserService implements UserRepo {
  static const String userUrl = baseUrl + "/api/users"; // base api url

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
  Future<User?> register(User user) async {
    // create an image
    //"https://avatars.dicebear.com/api/{}/{}.svg"
    Random random = Random();
    String randomChoice = spritesOptions[random.nextInt(spritesOptions.length)];
    String avatarImage =
        "https://avatars.dicebear.com/api/$randomChoice/${user.name}.svg";

    // create the body
    final body = jsonEncode({
      "name": user.name,
      "lastname": user.lastname,
      "email": user.email,
      "password": user.password,
      "image": avatarImage
    });

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Uri uri = Uri.parse(userUrl);
    Response response = await http.post(uri, body: body, headers: headers);
    if (response.statusCode != 200) {
      return null;
    }
    User logedInUser = userFromJson(response.body);
    return logedInUser;
  }

  // login
  @override
  Future<User?> login(String email, String password) async {
    // the url
    const String url = baseUrl + "/api/auth";

    // body we going to send
    final body = jsonEncode({
      "email": email,
      "password": password,
    });
    // the header
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Uri uri = Uri.parse(url);
    Response response = await http.post(uri, body: body, headers: headers);
    if (response.statusCode != 200) {
      return null;
    }
    User logedInUser = userFromJson(response.body);
    return logedInUser;
  }
}
