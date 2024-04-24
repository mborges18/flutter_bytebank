import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bitybank/authenticator/signin_bloc.dart';
import 'package:flutter_bitybank/authenticator/signin_event.dart';
import 'package:flutter_bitybank/authenticator/signin_state.dart';
import 'package:flutter_bitybank/components/buttons/button_outline.dart';
import 'package:flutter_bitybank/components/titles/title_center.dart';
import 'package:flutter_bitybank/home/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/buttons/button_filled.dart';
import '../components/buttons/button_switch.dart';
import '../components/inputs/input_text.dart';
import '../components/titles/subtitle_left.dart';
import '../components/titles/text_normal.dart';
import '../util/string/strings.dart';
import '../util/util.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String _email = "";
  String _password = "";
  bool _isKeepConnected = false;
  late final SignInBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = SignInBloc();
  }

  void _handlerStateEmail(String text) {
    setState(() {
      _email = text;
    });
    BlocProvider.of<SignInBloc>(context).add(SignInSetEmailEvent(email: text));
  }

  String? _handleErrorEmail(SignInState state) {
    if(state is SignInStateField) {
      return state.stateEmail.message;
    } else if(state is SignInStateEmail){
      return state.message;
    }
    return null;
  }

  void _handlerStatePassword(String text) {
    setState(() {
      _password = text;
    });
    BlocProvider.of<SignInBloc>(context).add(SignInSetPasswordEvent(password: text));
  }

  String? _handleErrorPass(SignInState state) {
    if(state is SignInStateField) {
      return state.statePassword.message;
    } else if(state is SignInStatePassword){
      return state.message;
    }
    return null;
  }

  void _handlerCheckButtonSwitch(bool isChecked) {
    setState(() {
      _isKeepConnected = isChecked;
    });
  }

  void _handlerEnableButton(SignInState state) {
    BlocProvider.of<SignInBloc>(context).add(SignInEnableButtonEvent(email: _email, password: _password));
  }

  void _login(SignInState state) {
    Util.closeKeyboard(context);
    BlocProvider.of<SignInBloc>(context).add(SignInSubmitEvent(email: _email, password: _password));
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SignInBloc, SignInState>(
          listenWhen: (context, state) { return (state is SignInStateSuccess); },
          listener: (context, state) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Home()),
              );
          },
          builder: (context, state){
            return viewSignIn(state);
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
                padding: const EdgeInsets.only(top: 24.0, bottom: 10.0),
                child: TitleCenter(text: titleAccess.toUpperCase(), icon: Icons.lock)),
            const SubTitleLeft(text: titleWellCome),
            const TextNormal(text: descriptionWellCome),
            const SizedBox(height: 8.0),
            Column(
              children: <Widget>[
                InputText(placeHolderEmail, hintEmail,
                    iconStart: Icons.alternate_email,
                    onValidatorListener: () {
                      return _handleErrorEmail(state);
                    }, onTextChangeListener: (text) {
                      _handlerStateEmail(text ?? "");
                      _handlerEnableButton(state);
                    }),
                InputText(placeHolderPassword, hintPassword,
                    iconStart: Icons.key,
                    isToggleSecret: true,
                    maxLength: 12,
                    onValidatorListener: () {
                      return _handleErrorPass(state);
                    }, onTextChangeListener: (text) {
                      _handlerStatePassword(text ?? "");
                      _handlerEnableButton(state);
                    }),
                ButtonSwitch(onChecked: _isKeepConnected, onCheckedListener: (isChecked) {
                  _handlerCheckButtonSwitch(isChecked);
                }),
                ButtonFilled(
                    textButton: actionAccess.toUpperCase(),
                    isEnabled: (state is SignInStateButton) ? state.isEnabled : false,
                    isLoading: (state is SignInStateLoading)==true ? true : false,
                    functionClick: () {
                      _login(state);
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
