import 'package:flutter/material.dart';
import 'package:flutter_bitybank/src/creditcard/form/model/creditcard_form_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/components/inputs/MaskType.dart';
import '../../../../core/components/inputs/input_text.dart';
import '../../../../util/string/strings.dart';
import '../bloc/creditcard_form_bloc.dart';
import '../bloc/creditcard_form_state.dart';

Widget inputNumber(
    CreditCardFormModel model,
    Function handlerErrorNumber,
    Function handlerEventNumber,
    Function handlerEventButton,
    ) {
  return BlocConsumer<CreditCardFormBloc, CreditCardFormState>(
      listener: (context, state) {},
      buildWhen: (context, state) {
        return (state is CreditCardFromStateNumber) || (state is CreditCardFromStateStep);
      },
      builder: (context, state) {
        print("STEP 1----------------------$state ${model.number} - flag: ${model.flag}");
        return Visibility(
          visible: (state is CreditCardFormStateInitial) ? true
              : (state is CreditCardFromStateNumber) ? true
              : (state is CreditCardFromStateStep) ? state.step==1 : false,
          child: InputText(
            textLabel: labelNumberCC,
            textHint: hintNumberCC,
            value: model.number,
            inputType: TextInputType.number,
            maskType: MaskType.creditCard,
            iconStart: Icons.credit_card_rounded,
            onValidatorListener: () {
              return handlerErrorNumber(state);
            },
            onTextChangeListener: (text) {
              handlerEventNumber(text ?? "");
              handlerEventButton();
            },
          ),
        );
      });
}