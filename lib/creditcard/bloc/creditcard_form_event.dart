
import '../model/creditcard_model.dart';

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
  final CreditCardModel model;
  CreditCardFormEnableButtonEvent({required this.model});
}

class CreditCardFormSubmitEvent extends CreditCardFormEvent {
  final CreditCardModel model;
  CreditCardFormSubmitEvent({required this.model});
}
