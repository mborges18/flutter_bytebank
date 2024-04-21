import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bitybank/authenticator/signin_bloc.dart';
import 'package:flutter_bitybank/authenticator/signin_event.dart';
import 'package:flutter_bitybank/components/buttons/button_outline.dart';
import 'package:flutter_bitybank/home/home_screen.dart';
import 'package:flutter_bitybank/util/validator/validator.dart';
import '../components/buttons/button_filled.dart';
import '../components/inputs/input_text.dart';
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
  final String _emailDb = "ctl_mborges@uolinc.com";
  final String _passwordDb = "123456";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? _email;
  String? _password;
  bool _isEnabledButton = false;
  bool _isKeepConnected = false;
  late final SignInBloc bloc;

  void _login() {
    Util.closeKeyboard(context);

    // _email = emailController.text;
    // _password = passwordController.text;

    bloc.add(SignInSetEmail(email: _email!));
    bloc.add(SignInSetPassword(password: _password!));
    bloc.add(SignInSetSubmitted());

    if (_email != null && _password != null) {
      if (_email!.isNotEmpty && _password!.isNotEmpty) {
        if (_email == _emailDb && _password == _passwordDb) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
          );
        }
      }
    }
  }

  String? _handleErrorEmail() {
    if (_email != null && _email!.isEmpty) {
      return 'Campo obrigatório';
    } else {
      if (_email != null && !Validator.isValidEmail(_email)) {
        return 'E-mail inválido';
      } else {
        return null;
      }
    }
  }

  String? _handleErrorPass() {
    return _password != null && _password!.isEmpty ? 'Campo obrigatório' : null;
  }

  void _handlerEnableButton() {
    setState(() {
      _isEnabledButton = _password != null &&
          _password!.isNotEmpty &&
          _email != null &&
          _email!.isNotEmpty &&
          Validator.isValidEmail(_email);
    });
  }

  @override
  void initState() {
    super.initState();
    bloc = SignInBloc();
  }

  @override
  void dispose() {
    //emailController.dispose();
    //passwordController.dispose();
    bloc.close();
    super.dispose();
  }

  void validateAndSave() {
    print('Form is valid');
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
              Column(
                children: <Widget>[
                  InputText(placeHolderEmail, hintEmail,
                      iconStart: Icons.alternate_email,
                      onValidatorListener: () {
                    return _handleErrorEmail();
                  }, onTextChangeListener: (text) {
                    setState(() {
                      _email = text;
                      _handlerEnableButton();
                    });
                  }),
                  InputText(placeHolderPassword, hintPassword,
                      iconStart: Icons.key,
                      isToggleSecret: true, onValidatorListener: () {
                    return _handleErrorPass();
                  }, onTextChangeListener: (text) {
                    setState(() {
                      _password = text;
                    });
                    _handlerEnableButton();
                  }),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        children: [
                          CupertinoSwitch(
                            activeColor: Theme.of(context).colorScheme.primary,
                            value: _isKeepConnected,
                            onChanged: (value) {
                              setState(() {
                                _isKeepConnected = value;
                              });
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
                  ButtonFilled(
                      textButton: actionAccess.toUpperCase(),
                      isEnabled: _isEnabledButton,
                      functionClick: () {
                        _login();
                      }),
                  ButtonOutline(actionForgotPassword.toUpperCase(),
                      functionClick: () {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
