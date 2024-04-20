import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bitybank/components/buttons/button_outline.dart';
import 'package:flutter_bitybank/home/home_screen.dart';
import 'package:flutter_bitybank/util/validator/validator.dart';
import '../components/buttons/button_filled.dart';
import '../components/inputs/input_text_form.dart';
import '../util/string/strings.dart';
import '../util/util.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key, required this.title});

  final String title;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String? _email;
  String? _password;
  final String _emailDb = "ctl_mborges@uolinc.com";
  final String _passwordDb = "123456";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isVisible = false;
  bool _isKeepConnectd = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _visibilityStateMsg(bool isVisible) {
    setState(() {
      _isVisible = isVisible;
    });
  }

  void _setKeepConnected(bool value) {
    setState(() {
      _isKeepConnectd = value;
    });
  }

  void _login() {
    Util.closeKeyboard(context);

    _email = emailController.text;
    _password = passwordController.text;

    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      if (_email!.isNotEmpty && _password!.isNotEmpty) {
        if (_email == _emailDb && _password == _passwordDb) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
          );
        } else {
          _visibilityStateMsg(true);
        }
      }
    } else {
      print('Form is invalid');
    }
  }

  void _forgotPassword() {
    print('Forgot password');
  }

  String? handleErrorEmail() {
    if (_email != null) {
      if (_email!.isEmpty) {
        return 'Campo obrigatório';
      } else {
        if (!Validator.isValidEmail(_email)) {
          return 'E-mail inválido';
        } else {
          return null;
        }
      }
    } else {
      return null;
    }
  }

  String? handleErrorPass() {
    return _password != null && _password!.isEmpty ? 'Campo obrigatório' : null;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void validateAndSave() {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      print('Form is valid');
    } else {
      print('Form is invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(
                      left: 0.0, top: 32.0, right: 0.0, bottom: 10.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.lock, size: 26),
                        Padding(
                            padding: const EdgeInsets.only(top: 4.0, left: 4.0),
                            child: Text(widget.title.toUpperCase(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 26.0)))
                      ])),
              const Padding(
                padding: EdgeInsets.only(
                    left: 0.0, top: 20.0, right: 0.0, bottom: 10.0),
                child: Text(titleWellCome,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
              ),
              const Padding(
                  padding: EdgeInsets.only(
                      left: 0.0, top: 0.0, right: 0.0, bottom: 10.0),
                  child: Text(
                    descriptionWellCome,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  )),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    InputTextForm(
                        placeHolderEmail, hintEmail, emailController,
                        iconStart: Icons.alternate_email,
                        onValidatorListener: () {
                          return handleErrorEmail();
                        },
                        onTextChangeListener: () {
                          _visibilityStateMsg(false);
                          _email = null;
                        }),
                    InputTextForm(
                        placeHolderPassword, hintPassword, passwordController,
                        iconStart: Icons.key,
                        isToggleSecret: true,
                        onValidatorListener: () {
                          return handleErrorPass();
                        },
                        onTextChangeListener: () {
                          _visibilityStateMsg(false);
                          _password = null;
                        }),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Row(
                          children: [
                            CupertinoSwitch(
                              activeColor:
                                  Theme.of(context).colorScheme.primary,
                              value: _isKeepConnectd,
                              onChanged: (value) {
                                _setKeepConnected(value);
                              },
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.0),
                              child: Text(titleKeepConnected,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0)),
                            )
                          ],
                        )),
                    ButtonFilled(actionAccess.toUpperCase(), functionClick: () {
                      _login();
                    }),
                    ButtonOutline(actionForgotPassword.toUpperCase(),
                        functionClick: () {
                      _forgotPassword();
                    }),
                  ],
                ),
              ),
              Visibility(
                visible: _isVisible,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
                  child: Text(
                    "Email ou senha inválido",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
