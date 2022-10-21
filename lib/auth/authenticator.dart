import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_bitybank/home/home.dart';
import 'package:flutter_bitybank/util/validator/validator.dart';

import '../components/buttons/button.dart';
import '../components/inputs/input_text.dart';
import '../components/inputs/input_text_form.dart';
import '../util/util.dart';

class Authenticator extends StatelessWidget {
  const Authenticator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Login(title: "Login");
  }
}

class Login extends StatefulWidget {
  const Login({super.key, required this.title});

  final String title;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? _email;
  String? _password;
  final String _emailDb = "ctl_mborges@uolinc.com";
  final String _passwordDb = "123456";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isVisible = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _visibilityStateMsg(bool isVisible) {
    setState(() {
      _isVisible = isVisible;
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
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 0.0),
                child: Text(
                  "POR FAVOR INFORME SEUS DADOS",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    InputTextForm('ex@@ex.com', 'E-mail', emailController,
                        validator: () {
                      return handleErrorEmail();
                    }, onTextChange: () {
                      _visibilityStateMsg(false);
                      _email = null;
                    }),
                    InputTextForm('******', 'Senha', passwordController,
                        validator: () {
                      return handleErrorPass();
                    }, onTextChange: () {
                      _visibilityStateMsg(false);
                      _password = null;
                    }),

                    ButtonText('ACESSAR', functionClick: () {
                      _login();
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
