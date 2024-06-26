
abstract class SignInEvent {}

class SignInSubmitEvent extends SignInEvent {
  final bool isKeepConnected;
  final String email;
  final String password;
  SignInSubmitEvent({required this.isKeepConnected, required this.email, required this.password});
}

class SignInSetEmailEvent extends SignInEvent {
  final String email;
  SignInSetEmailEvent({required this.email});
}

class SignInSetPasswordEvent extends SignInEvent {
  final String password;
  SignInSetPasswordEvent({required this.password});
}

class SignInEnableButtonEvent extends SignInEvent {
  final String email;
  final String password;
  SignInEnableButtonEvent({required this.email, required this.password});
}