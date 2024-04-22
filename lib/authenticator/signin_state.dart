import 'package:flutter/cupertino.dart';

@immutable
abstract class SignInState {}

class SignInStateInitial extends SignInState {}
class SignInStateLoading extends SignInState {}
class SignInStateSuccess extends SignInState {
  SignInStateSuccess(String s);
}
class SignInStateError extends SignInState {
  SignInStateError(Object? error);
}
