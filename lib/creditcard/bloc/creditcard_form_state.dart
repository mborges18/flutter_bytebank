
abstract class CreditCardFormState {}

class CreditCardFormStateInitial extends CreditCardFormState {}

class CreditCardFormStateLoading extends CreditCardFormState {}

class CreditCardFormStateSuccess extends CreditCardFormState {}

class CreditCardFormStateError extends CreditCardFormState {}

class CreditCardFormStateExists extends CreditCardFormState {}

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

class CreditCardFromStateStep extends CreditCardFormState {
  int step;
  CreditCardFromStateStep(this.step);
}

class CreditCardFlipper extends CreditCardFormState {}

class CreditCardFromStateButton extends CreditCardFormState {
  bool isEnabledPrev = false;
  bool isEnabledNext = false;
  CreditCardFromStateButton({required this.isEnabledNext, required this.isEnabledPrev});
}
