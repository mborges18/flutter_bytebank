import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/inputs/MaskType.dart';
import '../../../../core/components/inputs/input_text.dart';
import '../../../../util/string/strings.dart';
import '../bloc/signup_bloc.dart';
import '../bloc/signup_state.dart';

Widget inputPhone(
  String phone,
  Function handleErrorPhone,
  Function handlerEventPhone,
  Function handlerEventButton,
) {
  return BlocConsumer<SignUpBloc, SignUpState>(
      listenWhen: (context, state) {
        return (state is SignUpStatePhone);
      },
      listener: (context, state) {},
      buildWhen: (context, state) {
        return (state is SignUpStatePhone);
      },
      builder: (context, state) {
        return InputText(
          textLabel: labelPhone,
          textHint: hintPhone,
          value: phone,
          maskType: MaskType.phone,
          inputType: TextInputType.number,
          iconStart: Icons.settings_cell,
          onValidatorListener: () {
            return handleErrorPhone(state);
          },
          onTextChangeListener: (text) {
            handlerEventPhone(text ?? "");
            handlerEventButton(state);
          },
        );
      });
}