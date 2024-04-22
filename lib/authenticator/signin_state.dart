import 'package:flutter/cupertino.dart';

abstract class SignInState {}

class SignInStateInitial extends SignInState {}
class SignInStateLoading extends SignInState {}
class SignInStateSuccess extends SignInState {
  String value;
  SignInStateSuccess(this.value);
}
class SignInStateError extends SignInState {
  Object error;
  SignInStateError(this.error);
}
