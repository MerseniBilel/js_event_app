import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:js_event_app/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';

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

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            "assets/img/Sign_Up_bg.svg",
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fill,
          ),
          Center(
            child: SafeArea(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
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
                    const SizedBox(
                      height: defaultPadding * 2,
                    ),
                    SingUpForm(formkey: _formkey),
                    const SizedBox(
                      height: defaultPadding * 2,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            _formkey.currentState!.save();
                          }
                        },
                        child: const Text("Sing Up"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SingUpForm extends StatelessWidget {
  SingUpForm({Key? key, required this.formkey}) : super(key: key);

  final GlobalKey formkey;

  late String _name, _lastname, _email, _phoneNumber, _password;

  void printValues() {
    print(_name);
    print(_lastname);
    print(_email);
    print(_phoneNumber);
    print(_password);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextFieldName(fieldText: "Name"),
          TextFormField(
            validator: RequiredValidator(errorText: "Name is required"),
            decoration: const InputDecoration(
              hintText: "Bilel",
            ),
            onSaved: (name) => _name = name!,
          ),
          const TextFieldName(fieldText: "Lastname"),
          TextFormField(
            validator: RequiredValidator(errorText: "LastName is required"),
            decoration: const InputDecoration(
              hintText: "Merseni",
            ),
            onSaved: (lastname) => _lastname = lastname!,
          ),
          const TextFieldName(fieldText: "Email"),
          TextFormField(
            validator: EmailValidator(errorText: "Use a valid email"),
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: "example.example.com",
            ),
            onSaved: (email) => _email = email!,
          ),
          const TextFieldName(fieldText: "Phone number"),
          TextFormField(
            validator: RequiredValidator(errorText: "Phone Number is required"),
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              hintText: "+216 25 000 000",
            ),
            onSaved: (phone) => _phoneNumber = phone!,
          ),
          const TextFieldName(fieldText: "Password"),
          TextFormField(
            validator: passwordValidator,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: "********",
            ),
            onSaved: (password) => _password = password!,
            onChanged: (pass) => _password = pass,
          )
        ],
      ),
    );
  }
}

class TextFieldName extends StatelessWidget {
  const TextFieldName({
    Key? key,
    required this.fieldText,
  }) : super(key: key);

  final String fieldText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          bottom: defaultPadding / 3, top: defaultPadding / 3),
      child: Text(
        fieldText,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black54,
        ),
      ),
    );
  }
}
