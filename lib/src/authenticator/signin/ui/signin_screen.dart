
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/components/buttons/button_filled.dart';
import '../../../../core/components/buttons/button_outline.dart';
import '../../../../core/components/buttons/button_switch.dart';
import '../../../../core/components/dialogs/dialog_date_picker.dart';
import '../../../../core/components/dialogs/dialog_information.dart';
import '../../../../core/components/inputs/input_text.dart';
import '../../../../core/components/titles/subtitle_left.dart';
import '../../../../core/components/titles/text_normal.dart';
import '../../../../core/components/titles/title_center.dart';
import '../../../../util/string/strings.dart';
import '../../../../util/util.dart';
import '../bloc/signin_bloc.dart';
import '../bloc/signin_event.dart';
import '../bloc/signin_state.dart';
import 'input_email.dart';
import 'input_password.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String _email = "";
  String _password = "";
  bool _isKeepConnected = false;

  @override
  void initState() {
    super.initState();
    DialogDatePicker().init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handlerEventEmail(String text) {
    setState(() {
      _email = text;
    });
    BlocProvider.of<SignInBloc>(context)
        .add(SignInSetEmailEvent(email: text));
  }

  String? _handleErrorEmail(SignInState state) {
    return (state is SignInStateEmail) ? state.message : null;
  }

  void _handlerEventPassword(String text) {
    setState(() {
      _password = text;
    });
    BlocProvider.of<SignInBloc>(context)
        .add(SignInSetPasswordEvent(password: text));
  }

  String? _handleErrorPassword(SignInState state) {
    return (state is SignInStatePassword) ? state.message : null;
  }

  void _handlerCheckButtonSwitch(bool isChecked) {
    setState(() {
      _isKeepConnected = isChecked;
    });
  }

  void _handlerEventButton(SignInState state) {
    BlocProvider.of<SignInBloc>(context)
        .add(SignInEnableButtonEvent(email: _email, password: _password));
  }

  void _login(SignInState state) {
    Util.closeKeyboard(context);
    BlocProvider.of<SignInBloc>(context)
        .add(SignInSubmitEvent(isKeepConnected: _isKeepConnected, email: _email, password: _password));
  }

  @override
  Widget build(BuildContext context) {
    final email = (ModalRoute.of(context)?.settings.arguments) ?? "";
    if((email as String).isNotEmpty) {
      setState(() {
        _email = email;
      });
    }
    return Scaffold(body: viewSignIn());
  }

  Widget viewSignIn() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TitleCenter(text: titleAccess.toUpperCase(), icon: Icons.lock),
            const SizedBox(height: 8.0),
            const SubTitleLeft(text: titleWellCome),
            const TextNormal(text: descriptionWellCome),
            const SizedBox(height: 8.0),
            Column(
              children: <Widget>[
                inputEmail(_email, _handleErrorEmail, _handlerEventEmail, _handlerEventButton),
                inputPassword(_password, _handleErrorPassword, _handlerEventPassword, _handlerEventButton),
                ButtonSwitch(
                    onChecked: _isKeepConnected,
                    onCheckedListener: (isChecked) {
                      _handlerCheckButtonSwitch(isChecked);
                    }),
                BlocConsumer<SignInBloc, SignInState>(
                    listenWhen: (context, state) {
                  return (state is SignInStateSuccess) || (state is SignInStateError);
                }, listener: (context, state) {
                      if(state is SignInStateSuccess) {
                        Navigator.pushNamed(context, '/list');
                      } else {
                         AlertInformation(
                            title: titleInformation,
                            description: msgErrorUnKnow
                        ).showError(context);
                      }
                }, builder: (context, state) {
                  return ButtonFilled(
                      textButton: actionAccess.toUpperCase(),
                      isEnabled: (state is SignInStateButton)
                          ? state.isEnabled
                          : false,
                      isLoading:
                          (state is SignInStateLoading) == true ? true : false,
                      functionClick: () {
                        _login(state);
                      });
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
