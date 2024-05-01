
abstract class CreditCardFormState {}

class CreditCardFormStateInitial extends CreditCardFormState {}

class CreditCardFormStateLoading extends CreditCardFormState {}

class CreditCardFormStateSuccess extends CreditCardFormState {}

class CreditCardFormStateError extends CreditCardFormState {}

class CreditCardFromStateNumber extends CreditCardFormState {
  String? message;
  CreditCardFromStateNumber(this.message);
}

class CreditCardFromStateName extends CreditCardFormState {
  String? message;
  CreditCardFromStateName(this.message);
}

class CreditCardFromStateDate extends CreditCardFormState {
  String? message;
  CreditCardFromStateDate(this.message);
}

class CreditCardFromStateCvv extends CreditCardFormState {
  String? message;
  CreditCardFromStateCvv(this.message);
}

class CreditCardFromStateButton extends CreditCardFormState {
  bool isEnabled = false;
  CreditCardFromStateButton(this.isEnabled);
}
