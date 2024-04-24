import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../components/buttons/button_filled.dart';
import '../../../components/buttons/button_outline.dart';
import '../../../components/buttons/button_switch.dart';
import '../../../components/inputs/input_text.dart';
import '../../../components/titles/subtitle_left.dart';
import '../../../components/titles/text_normal.dart';
import '../../../components/titles/title_center.dart';
import '../../../home/home_screen.dart';
import '../../../util/string/strings.dart';
import '../../../util/util.dart';
import 'bloc/signup_bloc.dart';
import 'bloc/signup_event.dart';
import 'bloc/signup_state.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _email = "";
  String _password = "";
  bool _isKeepConnected = false;
  late final SignUpBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = SignUpBloc();
  }

  void _handlerEventEmail(String text) {
    setState(() {
      _email = text;
    });
    BlocProvider.of<SignUpBloc>(context)
        .add(SignUpSetEmailEvent(email: text));
  }

  String? _handleErrorEmail(SignUpState state) {
    return (state is SignUpStateEmail) ? state.message : null;
  }

  void _handlerEventPassword(String text) {
    setState(() {
      _password = text;
    });
    BlocProvider.of<SignUpBloc>(context)
        .add(SignUpSetPasswordEvent(password: text));
  }

  String? _handleErrorPass(SignUpState state) {
    return (state is SignUpStatePassword) ? state.message : null;
  }

  void _handlerCheckButtonSwitch(bool isChecked) {
    setState(() {
      _isKeepConnected = isChecked;
    });
  }

  void _handlerEventButton(SignUpState state) {
    BlocProvider.of<SignUpBloc>(context)
        .add(SignUpEnableButtonEvent(email: _email, password: _password));
  }

  void _login(SignUpState state) {
    Util.closeKeyboard(context);
    BlocProvider.of<SignUpBloc>(context)
        .add(SignUpSubmitEvent(email: _email, password: _password));
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: viewSignUp());
  }

  Widget viewSignUp() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(top: 24.0, bottom: 10.0),
                child: TitleCenter(
                    text: titleAccess.toUpperCase(), icon: Icons.lock)),
            const SubTitleLeft(text: titleWellCome),
            const TextNormal(text: descriptionWellCome),
            const SizedBox(height: 8.0),
            Column(
              children: <Widget>[
                BlocConsumer<SignUpBloc, SignUpState>(
                    listenWhen: (context, state) {
                      return (state is SignUpStateEmail);
                    },
                    listener: (context, state) {},
                    buildWhen: (context, state) {
                      return (state is SignUpStateEmail);
                    },
                    builder: (context, state) {
                      return InputText(placeHolderEmail, hintEmail,
                          iconStart: Icons.alternate_email,
                          onValidatorListener: () {
                            return _handleErrorEmail(state);
                          }, onTextChangeListener: (text) {
                            _handlerEventEmail(text ?? "");
                            _handlerEventButton(state);
                          });
                    }),
                BlocConsumer<SignUpBloc, SignUpState>(
                    listenWhen: (context, state) {
                      return (state is SignUpStatePassword);
                    },
                    listener: (context, state) {},
                    buildWhen: (context, state) {
                      return (state is SignUpStatePassword);
                    },
                    builder: (context, state) {
                      return InputText(placeHolderPassword, hintPassword,
                          iconStart: Icons.key,
                          isToggleSecret: true,
                          maxLength: 12, onValidatorListener: () {
                            return _handleErrorPass(state);
                          }, onTextChangeListener: (text) {
                            _handlerEventPassword(text ?? "");
                            _handlerEventButton(state);
                          });
                    }),
                ButtonSwitch(
                    onChecked: _isKeepConnected,
                    onCheckedListener: (isChecked) {
                      _handlerCheckButtonSwitch(isChecked);
                    }),
                BlocConsumer<SignUpBloc, SignUpState>(
                    listenWhen: (context, state) {
                      return (state is SignUpStateSuccess);
                    }, listener: (context, state) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                  );
                }, builder: (context, state) {
                  return ButtonFilled(
                      textButton: actionAccess.toUpperCase(),
                      isEnabled: (state is SignUpStateButton) ? state.isEnabled : false,
                      isLoading:
                      (state is SignUpStateLoading) == true ? true : false,
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
