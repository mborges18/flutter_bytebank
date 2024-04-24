
class SignUpEvent {}

class SignUpSubmitEvent extends SignUpEvent {
  final String email;
  final String password;
  SignUpSubmitEvent({required this.email, required this.password});
}

class SignUpSetEmailEvent extends SignUpEvent {
  final String email;
  SignUpSetEmailEvent({required this.email});
}

class SignUpSetPasswordEvent extends SignUpEvent {
  final String password;
  SignUpSetPasswordEvent({required this.password});
}

class SignUpEnableButtonEvent extends SignUpEvent {
  final String email;
  final String password;
  SignUpEnableButtonEvent({required this.email, required this.password});
}