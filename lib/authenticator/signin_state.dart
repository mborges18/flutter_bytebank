
abstract class SignInState {}

class SignInStateInitial extends SignInState {}

class SignInStateLoading extends SignInState {}

class SignInStateSuccess extends SignInState {
  Object object;
  SignInStateSuccess(this.object);
}

class SignInStateError extends SignInState {
  Object object;
  SignInStateError(this.object);
}

class SignInStateField extends SignInState {
  SignInStateEmail stateEmail;
  SignInStatePassword statePassword;
  SignInStateField(this.stateEmail, this.statePassword);
}

class SignInStateEmail extends SignInState {
  String? message;
  SignInStateEmail(this.message);
}

class SignInStatePassword extends SignInState {
  String? message;
  SignInStatePassword(this.message);
}

class SignInStateButton extends SignInState {
  bool isEnabled = false;
  SignInStateButton(this.isEnabled);
}
