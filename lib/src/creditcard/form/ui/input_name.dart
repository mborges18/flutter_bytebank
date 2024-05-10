import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/components/inputs/input_text.dart';
import '../../../../util/string/strings.dart';
import '../bloc/creditcard_form_bloc.dart';
import '../bloc/creditcard_form_state.dart';
import '../model/creditcard_form_model.dart';

Widget inputName(
    CreditCardFormModel model,
    Function handlerEventName,
    Function handlerEventButton,
    ) {
  return BlocConsumer<CreditCardFormBloc, CreditCardFormState>(
      listener: (context, state) {},
      buildWhen: (context, state) {
        return (state is CreditCardFromStateName) || (state is CreditCardFromStateStep);
      },
      builder: (context, state) {
        print("INPUT_NAME STEP 2----------------------$state ${model.nameUser}");
        return Visibility(
          visible: (state is CreditCardFromStateName) ? true
              : (state is CreditCardFromStateStep) ? state.step==2 : false,
          child: InputText(
            textLabel: labelNameLikeCC,
            textHint: hintName,
            value: model.nameUser,
            inputType: TextInputType.name,
            iconStart: Icons.person_2_outlined,
            onValidatorListener: () {
              return _handlerErrorName(state);
            },
            onTextChangeListener: (text) {
              handlerEventName(text.toString().toUpperCase());
              handlerEventButton();
            },
          ),
        );
      });
}

String? _handlerErrorName(CreditCardFormState state) {
  return (state is CreditCardFromStateName) ? state.message : null;
}