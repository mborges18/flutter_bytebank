import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/components/inputs/input_text.dart';
import '../../../../util/string/strings.dart';
import '../bloc/creditcard_form_bloc.dart';
import '../bloc/creditcard_form_state.dart';
import '../model/creditcard_form_model.dart';

Widget inputCvv({
  required CreditCardFormModel model,
  required Function eventCvv,
  required Function eventButton,
}) {
  return BlocConsumer<CreditCardFormBloc, CreditCardFormState>(
      listenWhen: (context, state) {
        return (state is CreditCardFromStateCvv);
      },
      listener: (context, state) {
      },
      buildWhen: (context, state) {
        return (state is CreditCardFromStateCvv) || (state is CreditCardFromStateStep);
      },
      builder: (context, state) {
        print("INPUT_CVV STEP 4----------------------$state ${model.cvv}");
        return Visibility(
          visible: (state is CreditCardFromStateStep) ? state.step==4 : false,
          child: InputText(
            textLabel: labelCvvCC,
            textHint: hintCvvCC,
            value: model.cvv,
            inputType: TextInputType.number,
            maxLength: 4,
            iconStart: Icons.security,
            onValidatorListener: () {
              return _handlerErrorCvv(state);
            },
            onTextChangeListener: (text) {
              eventCvv(text ?? "");
              eventButton();
            },
          ),
        );
      });
}

String? _handlerErrorCvv(CreditCardFormState state) {
  return (state is CreditCardFromStateCvv) ? state.message : null;
}