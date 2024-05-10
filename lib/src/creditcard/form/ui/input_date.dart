
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/components/inputs/MaskType.dart';
import '../../../../core/components/inputs/input_text.dart';
import '../../../../util/string/strings.dart';
import '../bloc/creditcard_form_bloc.dart';
import '../bloc/creditcard_form_state.dart';
import '../model/creditcard_form_model.dart';

Widget inputDate(
    CreditCardFormModel model,
    Function handlerEventDate,
    Function handlerEventButton,
    ) {

  return BlocConsumer<CreditCardFormBloc, CreditCardFormState>(
      listener: (context, state) {},
      buildWhen: (context, state) {
        return (state is CreditCardFromStateDate) || (state is CreditCardFromStateStep);
      },
      builder: (context, state) {
        print("INPUT_DATE STEP 3----------------------$state ${model.dateExpire}");
        return Visibility(
          visible: (state is CreditCardFromStateDate) ? true
              : (state is CreditCardFromStateStep) ? state.step==3 : false,
          child: InputText(
            textLabel: labelExpiredDate,
            textHint: hintDate,
            value: model.dateExpire,
            maskType: MaskType.dateCreditCard,
            inputType: TextInputType.number,
            iconStart: Icons.calendar_month_outlined,
            onValidatorListener: () {
              return _handlerErrorDate(state);
            },
            onTextChangeListener: (text) {
              handlerEventDate(text ?? "");
              handlerEventButton();
            },
          ),
        );
      });
}

String? _handlerErrorDate(CreditCardFormState state) {
  return (state is CreditCardFromStateDate) ? state.message : null;
}