import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:js_event_app/constants.dart';
import 'package:js_event_app/widgets/textfield_widget.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  static const headerTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  // default padding
  static const double kDefaultPadding = 20.0;

  final _formkey = GlobalKey<FormState>();

  final _keySubmit = GlobalKey<_LoginFormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: SafeArea(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Welcome Back",
                      style: headerTextStyle,
                    ),
                    Row(
                      children: [
                        const Text("You Dont have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            "Sing up",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: defaultPadding * 2,
                    ),
                    LoginForm(key: _keySubmit, formkey: _formkey),
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
                        child: const Text("Login"),
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

// login form
class LoginForm extends StatefulWidget {
  const LoginForm({Key? key, required this.formkey}) : super(key: key);

  final GlobalKey formkey;

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late String _email, _password;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextFieldName(fieldText: "Email"),
          TextFormField(
            validator: MultiValidator([
              RequiredValidator(errorText: "Email is required"),
              EmailValidator(errorText: "Email must be valid"),
            ]),
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: "example.example.com",
            ),
            onSaved: (email) => _email = email!,
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
