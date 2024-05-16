import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/inputs/input_text.dart';
import '../../../../util/string/strings.dart';
import '../bloc/signup_bloc.dart';
import '../bloc/signup_state.dart';

Widget inputEmail(
  String email,
  Function handleErrorEmail,
  Function handlerEventEmail,
  Function handlerEventButton,
) {
  return BlocConsumer<SignUpBloc, SignUpState>(
      listenWhen: (context, state) {
        return (state is SignUpStateEmail);
      },
      listener: (context, state) {},
      buildWhen: (context, state) {
        return (state is SignUpStateEmail);
      },
      builder: (context, state) {
        return InputText(
          textLabel: labelEmail,
          textHint: hintEmail,
          value: email,
          iconStart: Icons.alternate_email,
          inputType: TextInputType.emailAddress,
          onValidatorListener: () {
            return handleErrorEmail(state);
          },
          onTextChangeListener: (text) {
            handlerEventEmail(text ?? "");
            handlerEventButton(state);
          },
        );
      });
}