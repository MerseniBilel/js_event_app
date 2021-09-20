// LOGIN STATE
import 'package:equatable/equatable.dart';
import 'package:js_event_app/models/user_model.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadingLogin extends LoginState {}

class LoginDone extends LoginState {
  // ? if login is done, i need to return the loged user, so i'll create an Object of type User
  final User logedInUser;
  LoginDone({required this.logedInUser});
}

class ErrorLogin extends LoginState {}
