import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/components/buttons/button_filled.dart';
import '../../../../core/components/dialogs/dialog_information.dart';
import '../../../../util/string/strings.dart';
import '../../../../util/transfer_object.dart';
import '../bloc/creditcard_form_bloc.dart';
import '../bloc/creditcard_form_state.dart';

Widget inputButtons({
  required Function prev,
  required Function next,
  required Function(TransferObject) result,
}) {
  return BlocConsumer<CreditCardFormBloc, CreditCardFormState>(
      listenWhen: (context, state) {
        return (state is CreditCardFormStateSuccess) || (state is CreditCardFormStateError);
      },
      listener: (context, state) {
        if (state is CreditCardFormStateSuccess) {
          result(FilledData(state.model));
          const AlertInformation(
              title: titleInformation,
              description: msgErrorUnKnow).showSuccess(context);
        } else {
          const AlertInformation(
              title: titleInformation,
              description: msgErrorUnKnow).showError(context);
        }
      }, builder: (context, state) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: ButtonFilled(
              textButton: actionPrev.toUpperCase(),
              isEnabled: (state is CreditCardFromStateButton)
                  ? state.isEnabledPrev
                  : false,
              isLoading: false,
              functionClick: () {
                prev();
              }),
        ),
        const Spacer(),
        Expanded(
          flex: 5,
          child: ButtonFilled(
              textButton: _handlerNameButtonNext(state).toUpperCase(),
              isEnabled: (state is CreditCardFromStateButton)
                  ? state.isEnabledNext
                  : false,
              isLoading:
              (state is CreditCardFormStateLoading) == true
                  ? true
                  : false,
              functionClick: () {
                next();
              }),
        ),
      ],
    );
  });
}

String _handlerNameButtonNext(CreditCardFormState state){
  if(state is CreditCardFromStateButton) {
    print("Name button next -> ${state.textAction}");
    return state.textAction;
  }
  print("Name button next -> $actionNext");
  return actionNext;
}