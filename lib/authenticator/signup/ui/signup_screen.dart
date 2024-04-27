import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../components/buttons/button_filled.dart';
import '../../../../components/inputs/input_text.dart';
import '../../../../components/titles/subtitle_left.dart';
import '../../../../components/titles/text_normal.dart';
import '../../../../components/titles/title_center.dart';
import '../../../../home/home_screen.dart';
import '../../../../util/string/strings.dart';
import '../../../../util/util.dart';
import '../../../components/dialogs/dialog_information.dart';
import '../../../components/inputs/MaskType.dart';
import '../../../util/date/dates_util.dart';
import '../../authenticator_screen.dart';
import '../bloc/signup_bloc.dart';
import '../bloc/signup_event.dart';
import '../bloc/signup_state.dart';
import '../model/signup_model.dart';

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

  late final SignUpBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = SignUpBloc();
  }

  void _handlerEventName(String text) {
    _model.name = text;
    BlocProvider.of<SignUpBloc>(context)
        .add(SignUpSetNameEvent(name: text));
  }

  String? _handleErrorName(SignUpState state) {
    return (state is SignUpStateName) ? state.message : null;
  }

  void _handlerEventBirthDate(String text) {
    _model.birthDate = text;
    BlocProvider.of<SignUpBloc>(context)
        .add(SignUpSetBirthDateEvent(birthDate: text));
  }

  String? _handleErrorBirthDate(SignUpState state) {
    return (state is SignUpStateBirthDate) ? state.message : null;
  }

  void _handlerEventPhone(String text) {
    _model.phone = text;
    BlocProvider.of<SignUpBloc>(context)
        .add(SignUpSetPhoneEvent(phone: text));
  }

  String? _handleErrorPhone(SignUpState state) {
    return (state is SignUpStatePhone) ? state.message : null;
  }

  void _handlerEventEmail(String text) {
    _model.email = text;
    BlocProvider.of<SignUpBloc>(context)
        .add(SignUpSetEmailEvent(email: text));
  }

  String? _handleErrorEmail(SignUpState state) {
    return (state is SignUpStateEmail) ? state.message : null;
  }

  void _handlerEventPassword(String text) {
    _model.password = text;
    BlocProvider.of<SignUpBloc>(context)
        .add(SignUpSetPasswordEvent(password: text));
  }

  String? _handleErrorPassword(SignUpState state) {
    return (state is SignUpStatePassword) ? state.message : null;
  }

  void _handlerEventPasswordConfirm(String text) {
    _model.passwordConfirm = text;
    BlocProvider.of<SignUpBloc>(context)
        .add(SignUpSetPasswordConfirmEvent(passwordConfirm: text));
  }

  String? _handleErrorPasswordConfirm(SignUpState state) {
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
                BlocConsumer<SignUpBloc, SignUpState>(
                    listenWhen: (context, state) {
                      return (state is SignUpStateName);
                    },
                    listener: (context, state) {},
                    buildWhen: (context, state) {
                      return (state is SignUpStateName);
                    },
                    builder: (context, state) {
                      return InputText(
                        textLabel: placeHolderName,
                        textHint: hintName,
                        inputType: TextInputType.name,
                        iconStart: Icons.person,
                        onValidatorListener: () {
                          return _handleErrorName(state);
                        },
                        onTextChangeListener: (text) {
                          _handlerEventName(text ?? "");
                          _handlerEventButton(state);
                        },
                      );
                    }),
                BlocConsumer<SignUpBloc, SignUpState>(
                    listenWhen: (context, state) {
                      return (state is SignUpStateBirthDate);
                    },
                    listener: (context, state) {},
                    buildWhen: (context, state) {
                      return (state is SignUpStateBirthDate);
                    },
                    builder: (context, state) {
                      return InputText(
                        textLabel: placeHolderBirthDate,
                        textHint: hintBirthDate,
                        maskType: MaskType.date,
                        inputType: TextInputType.number,
                        iconStart: Icons.calendar_month_outlined,
                        onValidatorListener: () {
                          return _handleErrorBirthDate(state);
                        },
                        onTextChangeListener: (text) {
                          _handlerEventBirthDate(text ?? "");
                          _handlerEventButton(state);
                        },
                      );
                    }),
                BlocConsumer<SignUpBloc, SignUpState>(
                    listenWhen: (context, state) {
                      return (state is SignUpStatePhone);
                    },
                    listener: (context, state) {},
                    buildWhen: (context, state) {
                      return (state is SignUpStatePhone);
                    },
                    builder: (context, state) {
                      return InputText(
                        textLabel: placeHolderPhone,
                        textHint: hintPhone,
                        maskType: MaskType.phone,
                        inputType: TextInputType.number,
                        iconStart: Icons.settings_cell,
                        onValidatorListener: () {
                          return _handleErrorPhone(state);
                        },
                        onTextChangeListener: (text) {
                          _handlerEventPhone(text ?? "");
                          _handlerEventButton(state);
                        },
                      );
                    }),
                BlocConsumer<SignUpBloc, SignUpState>(
                    listenWhen: (context, state) {
                      return (state is SignUpStateEmail);
                    },
                    listener: (context, state) {},
                    buildWhen: (context, state) {
                      return (state is SignUpStateEmail);
                    },
                    builder: (context, state) {
                      return InputText(
                        textLabel: placeHolderEmail,
                        textHint: hintEmail,
                        iconStart: Icons.alternate_email,
                        inputType: TextInputType.emailAddress,
                        onValidatorListener: () {
                          return _handleErrorEmail(state);
                        },
                        onTextChangeListener: (text) {
                          _handlerEventEmail(text ?? "");
                          _handlerEventButton(state);
                        },
                      );
                    }),
                const SizedBox(height: 16.0),
                const SubTitleLeft(text: titleDataAccess),
                const SizedBox(height: 16.0),
                BlocConsumer<SignUpBloc, SignUpState>(
                    listenWhen: (context, state) {
                      return (state is SignUpStatePassword);
                    },
                    listener: (context, state) {},
                    buildWhen: (context, state) {
                      return (state is SignUpStatePassword);
                    },
                    builder: (context, state) {
                      return InputText(
                        textLabel: placeHolderPassword,
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
                BlocConsumer<SignUpBloc, SignUpState>(
                    listenWhen: (context, state) {
                      return (state is SignUpStatePasswordConfirm);
                    },
                    listener: (context, state) {},
                    buildWhen: (context, state) {
                      return (state is SignUpStatePasswordConfirm);
                    },
                    builder: (context, state) {
                      return InputText(
                        textLabel: placeHolderPassword,
                        textHint: hintPassword,
                        iconStart: Icons.key,
                        isToggleSecret: true,
                        maxLength: 12,
                        onValidatorListener: () {
                          return _handleErrorPasswordConfirm(state);
                        },
                        onTextChangeListener: (text) {
                          _handlerEventPasswordConfirm(text ?? "");
                          _handlerEventButton(state);
                        },
                      );
                    }),
                BlocConsumer<SignUpBloc, SignUpState>(
                    listenWhen: (context, state) {
                  return (state is SignUpStateSuccess) || (state is SignUpStateError);
                }, listener: (context, state) {
                      if((state is SignUpStateSuccess)) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AuthenticatorScreen()),
                        );
                      } else {
                        const AlertInformation(
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
                      isLoading:
                          (state is SignUpStateLoading) == true ? true : false,
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
