import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

// color pallet
const primaryColor = Color(0xFF255ED6);
const textColor = Color(0xFF35364F);
const backgroundColor = Color(0xFFE6EFF9);
const redColor = Color(0xFFE85050);

const String baseUrl = "http://687a-41-62-162-9.ngrok.io";

// default padding
const defaultPadding = 16.0;

// default textfieldBorder color
OutlineInputBorder textFieldBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: primaryColor.withOpacity(0.1),
  ),
);

// password validator
final passwordValidator = MultiValidator(
  [
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(6, errorText: 'password must be at least 6 digits long'),
  ],
);

BoxShadow kDefaultShadow = BoxShadow(
  color: Colors.grey.withOpacity(0.2),
  spreadRadius: 5,
  blurRadius: 7,
  offset: const Offset(0, 3),
);
