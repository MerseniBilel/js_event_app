import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.name,
    required this.lastname,
    required this.email,
    required this.password,
    this.image,
  });

  String name;
  String lastname;
  String email;
  String? password;
  String? image;

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        lastname: json["lastname"],
        email: json["email"],
        password: json["password"],
        image: json["image"],
      );
  Map<String, dynamic> toJson() => {
        "name": name,
        "lastname": lastname,
        "email": email,
        "password": password,
        "image": image,
      };
}
