
import 'package:bloc/bloc.dart';
import 'package:flutter_bitybank/creditcard/bloc/creditcard_form_state.dart';

import 'creditcard_form_event.dart';

class CreditCardFormBloc extends Bloc<CreditCardFormEvent, CreditCardFormState> {
  CreditCardFormBloc() : super(CreditCardFormStateInitial());
}