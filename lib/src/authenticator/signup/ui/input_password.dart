import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/inputs/input_text.dart';
import '../../../../util/string/strings.dart';
import '../bloc/signup_bloc.dart';
import '../bloc/signup_state.dart';

Widget inputPassword(
  String password,
  Function handleErrorPassword,
  Function handlerEventPassword,
  Function handlerEventButton,
) {
  return BlocConsumer<SignUpBloc, SignUpState>(
      listenWhen: (context, state) {
        return (state is SignUpStatePassword);
      },
      listener: (context, state) {},
      buildWhen: (context, state) {
        return (state is SignUpStatePassword);
      },
      builder: (context, state) {
        return InputText(
          textLabel: labelPassword,
          textHint: hintPassword,
          value: password,
          iconStart: Icons.key,
          isToggleSecret: true,
          maxLength: 12,
          onValidatorListener: () {
            return handleErrorPassword(state);
          },
          onTextChangeListener: (text) {
            handlerEventPassword(text ?? "");
            handlerEventButton(state);
          },
        );
      });
}