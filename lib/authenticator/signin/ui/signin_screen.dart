import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../components/buttons/button_filled.dart';
import '../../../components/buttons/button_outline.dart';
import '../../../components/buttons/button_switch.dart';
import '../../../components/dialogs/dialog_date_picker.dart';
import '../../../components/dialogs/dialog_information.dart';
import '../../../components/inputs/input_text.dart';
import '../../../components/titles/subtitle_left.dart';
import '../../../components/titles/text_normal.dart';
import '../../../components/titles/title_center.dart';
import '../../../home/ui/home_screen.dart';
import '../../../util/string/strings.dart';
import '../../../util/util.dart';
import '../bloc/signin_bloc.dart';
import '../bloc/signin_event.dart';
import '../bloc/signin_state.dart';

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
    DialogDatePicker().init();
    bloc = SignInBloc();
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
        .add(SignInSubmitEvent(email: _email, password: _password));
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                BlocConsumer<SignInBloc, SignInState>(
                    listenWhen: (context, state) {
                      return (state is SignInStateEmail);
                    },
                    listener: (context, state) {},
                    buildWhen: (context, state) {
                      return (state is SignInStateEmail);
                    },
                    builder: (context, state) {
                      return InputText(
                        textLabel: labelEmail,
                        textHint: hintEmail,
                        inputType: TextInputType.emailAddress,
                        iconStart: Icons.alternate_email,
                        onValidatorListener: () {
                          return _handleErrorEmail(state);
                        },
                        onTextChangeListener: (text) {
                          _handlerEventEmail(text ?? "");
                          _handlerEventButton(state);
                        },
                      );
                    }),
                BlocConsumer<SignInBloc, SignInState>(
                    listenWhen: (context, state) {
                      return (state is SignInStatePassword);
                    },
                    listener: (context, state) {},
                    buildWhen: (context, state) {
                      return (state is SignInStatePassword);
                    },
                    builder: (context, state) {
                      return InputText(
                        textLabel: labelPassword,
                        textHint: hintPassword,
                        iconStart: Icons.key,
                        isToggleSecret: true,
                        maxLength: 12,
                        onValidatorListener: () {
                          return _handleErrorPassword(state);
                        },
                        onTextChangeListener: (text) {
                          _handlerEventPassword(text ?? "");
                          _handlerEventButton(state);
                        },
                      );
                    }),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const HomeScreen()),
                        );
                      } else {
                        const AlertInformation(
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
