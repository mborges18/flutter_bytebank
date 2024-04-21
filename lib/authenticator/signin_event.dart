abstract class SignInEvent {}

class SignInSetEmail extends SignInEvent {
  final String email;
  SignInSetEmail({required this.email});
}

class SignInSetPassword extends SignInEvent {
  final String password;
  SignInSetPassword({required this.password});
}

class SignInLoading extends SignInEvent {}

class SignInSubmitted extends SignInEvent {}
