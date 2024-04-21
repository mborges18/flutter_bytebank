import 'package:flutter_bitybank/authenticator/signin_event.dart';
import 'package:flutter_bitybank/authenticator/signin_repository.dart';
import 'package:flutter_bitybank/authenticator/signin_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final repository = SignInRespository();

  SignInBloc() : super(SignInState()) {
    on<SignInSetLoading>((event, emit) =>
        emit(SignInState().setSubimitted(formStatus: SubimittingFormStatus())));

    on<SignInSetSubmitted>((event, emit) =>
        emit(SignInState().setSubimitted(formStatus: SuccessFormStatus())));
  }
}
