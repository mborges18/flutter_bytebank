import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/inputs/input_text.dart';
import '../../../../util/string/strings.dart';
import '../bloc/signup_bloc.dart';
import '../bloc/signup_state.dart';

Widget inputPasswordConfirm(
  String passwordConfirm,
  Function handleErrorPasswordConfirm,
  Function handlerEventPasswordConfirm,
  Function handlerEventButton,
) {
  return BlocConsumer<SignUpBloc, SignUpState>(
      listenWhen: (context, state) {
        return (state is SignUpStatePasswordConfirm);
      },
      listener: (context, state) {},
      buildWhen: (context, state) {
        return (state is SignUpStatePasswordConfirm);
      },
      builder: (context, state) {
        return InputText(
          textLabel: labelPasswordConfirm,
          textHint: hintPassword,
          value: passwordConfirm,
          iconStart: Icons.key,
          isToggleSecret: true,
          maxLength: 12,
          onValidatorListener: () {
            return handleErrorPasswordConfirm(state);
          },
          onTextChangeListener: (text) {
            handlerEventPasswordConfirm(text ?? "");
            handlerEventButton(state);
          },
        );
      });
}