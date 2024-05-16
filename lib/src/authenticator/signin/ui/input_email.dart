import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/inputs/input_text.dart';
import '../../../../util/string/strings.dart';
import '../bloc/signin_bloc.dart';
import '../bloc/signin_state.dart';

Widget inputEmail(
    String email,
    Function handleErrorEmail,
    Function handlerEventEmail,
    Function handlerEventButton,
    ) {
  return BlocConsumer<SignInBloc, SignInState>(
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
          value: email,
          inputType: TextInputType.emailAddress,
          iconStart: Icons.alternate_email,
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