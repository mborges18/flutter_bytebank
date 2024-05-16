import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/components/buttons/button_filled.dart';
import '../../../../util/string/strings.dart';
import '../bloc/creditcard_form_bloc.dart';
import '../bloc/creditcard_form_state.dart';

Widget inputButtons({
  required Function prev,
  required Function next,
}) {
  return BlocConsumer<CreditCardFormBloc, CreditCardFormState>(
      listenWhen: (context, state) {
        return (state is CreditCardFormStateSuccess) || (state is CreditCardFormStateError);
      },
      listener: (context, state) {
      },
      builder: (context, state) {
    print("BUTTONS----------------------$state ${(state is CreditCardFromStateButton) ? "${state.isEnabledPrev} - ${state.isEnabledNext}" : {} }");
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