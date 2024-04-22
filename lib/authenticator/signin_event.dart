import 'package:flutter/cupertino.dart';

@immutable
abstract class SignInEvent {}

class SignIn extends SignInEvent {
  final String email;
  final String password;

  SignIn({required this.email, required this.password});
}
