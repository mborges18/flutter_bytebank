
import '../model/creditcard_form_model.dart';

abstract class CreditCardFormEvent {}

class CreditCardFormNumberEvent extends CreditCardFormEvent {
  final String number;
  CreditCardFormNumberEvent({required this.number});
}

class CreditCardFormNameEvent extends CreditCardFormEvent {
  final String name;
  CreditCardFormNameEvent({required this.name});
}

class CreditCardFormDateEvent extends CreditCardFormEvent {
  final String date;
  CreditCardFormDateEvent({required this.date});
}

class CreditCardFormCvvEvent extends CreditCardFormEvent {
  final String cvv;
  CreditCardFormCvvEvent({required this.cvv});
}

class CreditCardFormEnableButtonEvent extends CreditCardFormEvent {
  final CreditCardFormModel model;
  CreditCardFormEnableButtonEvent({required this.model});
}

class CreditCardFormPrevEvent extends CreditCardFormEvent {
  final CreditCardFormModel model;
  CreditCardFormPrevEvent({required this.model});
}

class CreditCardFormNextEvent extends CreditCardFormEvent {
  final CreditCardFormModel model;
  CreditCardFormNextEvent({required this.model});
}
