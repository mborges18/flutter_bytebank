import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/inputs/MaskType.dart';
import '../../../../core/components/inputs/input_text.dart';
import '../../../../util/string/strings.dart';
import '../bloc/signup_bloc.dart';
import '../bloc/signup_state.dart';

Widget inputBirthDate(
  String birthDate,
  Function handleErrorBirthDate,
  Function handlerEventBirthDate,
  Function handlerEventButton,
) {
  return BlocConsumer<SignUpBloc, SignUpState>(
      listenWhen: (context, state) {
        return (state is SignUpStateBirthDate);
      },
      listener: (context, state) {},
      buildWhen: (context, state) {
        return (state is SignUpStateBirthDate);
      },
      builder: (context, state) {
        return InputText(
          textLabel: labelBirthDate,
          textHint: hintDate,
          value: birthDate,
          maskType: MaskType.date,
          inputType: TextInputType.number,
          iconStart: Icons.calendar_month_outlined,
          onValidatorListener: () {
            return handleErrorBirthDate(state);
          },
          onTextChangeListener: (text) {
            handlerEventBirthDate(text ?? "");
            handlerEventButton(state);
          },
        );
      });
}