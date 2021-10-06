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
                            "Welcome Back",
                            style: Register.headerTextStyle,
                          ),
                    _hidebutton
                        ? const SizedBox()
                        : Row(
                            children: [
                              const Text("Want To Learn More?"),
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "Facebook",
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
  late String _email, _password;

  bool _isloading = false;
  bool _error = false;
  late User? newUser;

  register() async {
    setState(() {
      _isloading = true;
    });

    UserService userRepo = UserService();
    Future<User?> logedInUser = userRepo.login(_email, _password);
    logedInUser.then((value) {
      setState(() {
        newUser = value;
        if (newUser == null) {
          setState(() {
            _error = true;
            _isloading = false;
          });
          print("error");
        } else {
          print("every thing is okey");
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
                          "Error while siginig in, Check Your Credientials",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : const Text(''),
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
