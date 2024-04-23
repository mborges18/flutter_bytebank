import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bitybank/authenticator/signin_bloc.dart';
import 'package:flutter_bitybank/authenticator/signin_event.dart';
import 'package:flutter_bitybank/authenticator/signin_state.dart';
import 'package:flutter_bitybank/components/buttons/button_outline.dart';
import 'package:flutter_bitybank/home/home_screen.dart';
import 'package:flutter_bitybank/util/validator/validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/buttons/button_filled.dart';
import '../components/inputs/input_text.dart';
import '../util/string/strings.dart';
import '../util/util.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
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

  @override
  void initState() {
    super.initState();
    bloc = SignInBloc();
  }

  void _login() {
    Util.closeKeyboard(context);

    // if (_email != null && _password != null) {
    //   if (_email!.isNotEmpty && _password!.isNotEmpty) {
    //     if (_email == _emailDb && _password == _passwordDb) {
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(builder: (context) => const Home()),
    //       );
    //     }
    //   }
    // }
  }

  String? _handleErrorEmail(SignInState state) {
    if (_email != null && _email!.isEmpty) {
      return 'Campo obrigatório';
    } else if (_email != null && !Validator.isValidEmail(_email)) {
      return 'E-mail inválido';
    } else if(state is SignInStateUnauthorized) {
      return 'Seu e-mail pode estar errado';
    } else {
      return null;
    }

  }

  String? _handleErrorPass(SignInState state) {
    if(_password != null && _password!.isEmpty) {
      return 'Campo obrigatório';
    } else if(state is SignInStateUnauthorized) {
      return 'Sua senha pode estar errada';
    } else {
      return null;
    }
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
      body: BlocConsumer<SignInBloc, SignInState>(
          listener: (context, state) {
            if(state is SignInStateInitial) {
              print('listener-------------------------------$state');
            }
            else if(state is SignInStateLoading) {
              print('listener-------------------------------$state');
            }
            else if(state is SignInStateError) {
              print('listener-------------------------------$state ${state.object}');
            }
            else if(state is SignInStateUnauthorized) {
              print('listener-------------------------------$state ${state.object}');
            }
            else if(state is SignInStateSuccess) {
              print('listener-------------------------------$state ${state.value}');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Home()),
              );
            }
          },
          builder: (context, state){
            if(state is SignInStateLoading) {
              print('builder-------------------------------$state');
              return viewSignIn(state);
            }
            else if(state is SignInStateError) {
              print('builder-------------------------------$state');
              return viewSignIn(state);
            }
            else if(state is SignInStateUnauthorized) {
              print('builder-------------------------------$state');
              return viewSignIn(state);
            }
            else  {
              //success
              //print('listener-------------------------------$state');
              return viewSignIn(state);
            }
          }
      )
    );
  }

  Widget viewSignIn(SignInState state) {
    return SingleChildScrollView(
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
                          child: Text(titleAccess.toUpperCase(),
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
                      return _handleErrorEmail(state);
                    }, onTextChangeListener: (text) {
                      setState(() {
                        _email = text;
                        _handlerEnableButton();
                      });
                    }),
                InputText(placeHolderPassword, hintPassword,
                    iconStart: Icons.key,
                    isToggleSecret: true,
                    onValidatorListener: () {
                      return _handleErrorPass(state);
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
                    isLoading: (state is SignInStateLoading)==true ? true : false,
                    functionClick: () {
                      _login();
                      BlocProvider.of<SignInBloc>(context).add(SignIn(email: _email!, password: _password!));
                    }),
                ButtonOutline(actionForgotPassword.toUpperCase(),
                    functionClick: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
