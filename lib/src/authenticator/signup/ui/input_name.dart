import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/inputs/input_text.dart';
import '../../../../util/string/strings.dart';
import '../bloc/signup_bloc.dart';
import '../bloc/signup_state.dart';

Widget inputName(
  String name,
  Function handleErrorName,
  Function handlerEventName,
  Function handlerEventButton,
) {
  return BlocConsumer<SignUpBloc, SignUpState>(
      listenWhen: (context, state) {
        return (state is SignUpStateName);
      },
      listener: (context, state) {},
      buildWhen: (context, state) {
        return (state is SignUpStateName);
      },
      builder: (context, state) {
        return InputText(
          textLabel: labelNameFull,
          textHint: hintName,
          value: name,
          inputType: TextInputType.name,
          iconStart: Icons.person,
          onValidatorListener: () {
            return handleErrorName(state);
          },
          onTextChangeListener: (text) {
            handlerEventName(text ?? "");
            handlerEventButton(state);
            print("NAME---------------------------$text");
          },
        );
      });
}