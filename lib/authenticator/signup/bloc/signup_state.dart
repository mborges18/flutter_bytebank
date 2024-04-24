
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

class SignUpStateEmail extends SignUpState {
  String? message;
  SignUpStateEmail(this.message);
}

class SignUpStatePassword extends SignUpState {
  String? message;
  SignUpStatePassword(this.message);
}

class SignUpStateButton extends SignUpState {
  bool isEnabled = false;
  SignUpStateButton(this.isEnabled);
}