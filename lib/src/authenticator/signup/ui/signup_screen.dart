import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/components/buttons/button_filled.dart';
import '../../../../core/components/dialogs/dialog_information.dart';
import '../../../../core/components/inputs/input_text.dart';
import '../../../../core/components/titles/subtitle_left.dart';
import '../../../../core/components/titles/text_normal.dart';
import '../../../../core/components/titles/title_center.dart';
import '../../../../util/string/strings.dart';
import '../../../../util/util.dart';
import '../bloc/signup_bloc.dart';
import '../bloc/signup_event.dart';
import '../bloc/signup_state.dart';
import '../model/signup_model.dart';
import 'input_birthdate.dart';
import 'input_email.dart';
import 'input_name.dart';
import 'input_password_confirm.dart';
import 'input_phone.dart';
import 'input_password.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpModel _model = SignUpModel(
    name: "",
    birthDate: "",
    phone: "",
    email: "",
    password: "",
    passwordConfirm: "",
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handlerEventName(String text) {
    setState(() {
      _model.name = text;
    });
    BlocProvider.of<SignUpBloc>(context)
        .add(SignUpSetNameEvent(name: text));
  }

  String? _handlerErrorName(SignUpState state) {
    return (state is SignUpStateName) ? state.message : null;
  }

  void _handlerEventBirthDate(String text) {
    setState(() {
      _model.birthDate = text;
    });
    BlocProvider.of<SignUpBloc>(context)
        .add(SignUpSetBirthDateEvent(birthDate: text));
  }

  String? _handlerErrorBirthDate(SignUpState state) {
    return (state is SignUpStateBirthDate) ? state.message : null;
  }

  void _handlerEventPhone(String text) {
    setState(() {
      _model.phone = text;
    });
    BlocProvider.of<SignUpBloc>(context)
        .add(SignUpSetPhoneEvent(phone: text));
  }

  String? _handlerErrorPhone(SignUpState state) {
    return (state is SignUpStatePhone) ? state.message : null;
  }

  void _handlerEventEmail(String text) {
    setState(() {
      _model.email = text;
    });
    BlocProvider.of<SignUpBloc>(context)
        .add(SignUpSetEmailEvent(email: text));
  }

  String? _handlerErrorEmail(SignUpState state) {
    return (state is SignUpStateEmail) ? state.message : null;
  }

  void _handlerEventPassword(String text) {
    setState(() {
      _model.password = text;
    });
    BlocProvider.of<SignUpBloc>(context)
        .add(SignUpSetPasswordEvent(password: text));
  }

  String? _handlerErrorPassword(SignUpState state) {
    return (state is SignUpStatePassword) ? state.message : null;
  }

  void _handlerEventPasswordConfirm(String text) {
    setState(() {
      _model.passwordConfirm = text;
    });
    BlocProvider.of<SignUpBloc>(context)
        .add(SignUpSetPasswordConfirmEvent(passwordConfirm: text));
  }

  String? _handlerErrorPasswordConfirm(SignUpState state) {
    return (state is SignUpStatePasswordConfirm) ? state.message : null;
  }

  void _handlerEventButton(SignUpState state) {
    BlocProvider.of<SignUpBloc>(context)
        .add(SignUpEnableButtonEvent(model: _model));
  }

  void _register(SignUpState state) {
    Util.closeKeyboard(context);
    BlocProvider.of<SignUpBloc>(context)
        .add(SignUpSubmitEvent(model: _model));
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
            TitleCenter(text: titleRegister.toUpperCase(), icon: Icons.assignment_ind_rounded),
            const SizedBox(height: 8.0),
            const SubTitleLeft(text: titleWellCome),
            const TextNormal(text: descriptionWellCome),
            const SizedBox(height: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SubTitleLeft(text: titleDataPerson),
                const SizedBox(height: 16.0),
                inputName(_model.name, _handlerErrorName, _handlerEventName, _handlerEventButton),
                inputBirthDate(_model.birthDate, _handlerErrorBirthDate, _handlerEventBirthDate, _handlerEventButton),
                inputPhone(_model.phone, _handlerErrorPhone, _handlerEventPhone, _handlerEventButton),
                inputEmail(_model.email, _handlerErrorEmail, _handlerEventEmail, _handlerEventButton),

                const SizedBox(height: 16.0),
                const SubTitleLeft(text: titleDataAccess),
                const SizedBox(height: 16.0),

                inputPassword(_model.password, _handlerErrorPassword, _handlerEventPassword, _handlerEventButton),
                inputPasswordConfirm(_model.passwordConfirm, _handlerErrorPasswordConfirm, _handlerEventPasswordConfirm, _handlerEventButton),

                BlocConsumer<SignUpBloc, SignUpState>(
                    listenWhen: (context, state) {
                  return (state is SignUpStateSuccess) || (state is SignUpStateError);
                }, listener: (context, state) {
                      if((state is SignUpStateSuccess)) {
                        Navigator.pushNamed(context, '/', arguments: _model.email);
                      } else {
                         AlertInformation(
                            title: titleInformation,
                            description: msgErrorUnKnow
                        ).showError(context);
                      }
                }, builder: (context, state) {
                  return ButtonFilled(
                      textButton: actionRegister.toUpperCase(),
                      isEnabled: (state is SignUpStateButton)
                          ? state.isEnabled
                          : false,
                      isLoading: (state is SignUpStateLoading) == true ? true : false,
                      functionClick: () {
                        _register(state);
                      });
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
