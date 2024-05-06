
abstract class SignUpState {}

class SignUpStateInitial extends SignUpState {}

class SignUpStateLoading extends SignUpState {}

class SignUpStateSuccess extends SignUpState {
  Object object;
  SignUpStateSuccess(this.object);
}

class SignUpStateError extends SignUpState {
  Object object;
  SignUpStateError(this.object);
}

class SignUpStateName extends SignUpState {
  String? message;
  SignUpStateName(this.message);
}

class SignUpStateBirthDate extends SignUpState {
  String? message;
  SignUpStateBirthDate(this.message);
}

class SignUpStatePhone extends SignUpState {
  String? message;
  SignUpStatePhone(this.message);
}

class SignUpStateEmail extends SignUpState {
  String? message;
  SignUpStateEmail(this.message);
}

class SignUpStatePassword extends SignUpState {
  String? message;
  SignUpStatePassword(this.message);
}

class SignUpStatePasswordConfirm extends SignUpState {
  String? message;
  SignUpStatePasswordConfirm(this.message);
}

class SignUpStateButton extends SignUpState {
  bool isEnabled = false;
  SignUpStateButton(this.isEnabled);
}