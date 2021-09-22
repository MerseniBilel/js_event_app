import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:js_event_app/constants.dart';
import 'package:js_event_app/models/user_model.dart';
import 'package:js_event_app/services/user_services.dart';
import 'package:js_event_app/widgets/textfield_widget.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  static const headerTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  // default padding
  static const double kDefaultPadding = 20.0;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formkey = GlobalKey<FormState>();

  final _keySubmit = GlobalKey<_SingUpFormState>();

  bool _hidebutton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: Register.kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _hidebutton
                        ? const SizedBox()
                        : const Text(
                            "Create Account",
                            style: Register.headerTextStyle,
                          ),
                    _hidebutton
                        ? const SizedBox()
                        : Row(
                            children: [
                              const Text("Aleady Hava an account?"),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed("login");
                                },
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
                    SingUpForm(key: _keySubmit, formkey: _formkey),
                    const SizedBox(
                      height: defaultPadding * 2,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: _hidebutton
                          ? const SizedBox()
                          : ElevatedButton(
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  setState(() {
                                    _hidebutton = true;
                                  });

                                  _formkey.currentState!.save();
                                  _keySubmit.currentState!.register();

                                  setState(() {
                                    _hidebutton = false;
                                  });
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

class SingUpForm extends StatefulWidget {
  const SingUpForm({Key? key, required this.formkey}) : super(key: key);

  final GlobalKey formkey;

  @override
  State<SingUpForm> createState() => _SingUpFormState();
}

class _SingUpFormState extends State<SingUpForm> {
  late String _name, _lastname, _email, _password;

  bool _isloading = false;
  bool _error = false;
  late User? newUser;

  register() async {
    setState(() {
      _isloading = true;
    });

    User userForm = User(
        name: _name, lastname: _lastname, email: _email, password: _password);
    UserService userRepo = UserService();
    Future<User?> logedInUser = userRepo.register(userForm);
    logedInUser.then((value) {
      setState(() {
        newUser = value;
        if (newUser == null) {
          setState(() {
            _error = true;
            _isloading = false;
          });
        } else {
          Navigator.of(context)
              .pushReplacementNamed("home", arguments: {"logedUser": newUser});
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isloading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Form(
            key: widget.formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _error
                    ? const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Account allredy exsit try with another email or sign in ",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : const Text(''),
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
                  validator:
                      RequiredValidator(errorText: "LastName is required"),
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
