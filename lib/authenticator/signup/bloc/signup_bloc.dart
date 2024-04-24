
import 'package:bloc/bloc.dart';
import 'package:flutter_bitybank/authenticator/signup/bloc/signup_event.dart';
import 'package:flutter_bitybank/authenticator/signup/bloc/signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpStateInitial());
}