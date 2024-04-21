import 'package:flutter_bitybank/authenticator/signin_event.dart';
import 'package:flutter_bitybank/authenticator/signin_repository.dart';
import 'package:flutter_bitybank/authenticator/signin_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final repository = SignInRespository();

  SignInBloc() : super(SignInState());

  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    if (event is SignInSetEmail) {
      yield state.setEamil(email: event.email);
    }

    if (event is SignInSetPassword) {
      yield state.setPassword(password: event.password);
    }

    if (event is SignInLoading) {
      yield state.setSubimitted(formStatus: SubimittingFormStatus());

      try {
        await repository.signIn(state.email, state.password);
        yield state.setSubimitted(formStatus: SuccessFormStatus());
      } catch (e) {
        state.setSubimitted(
            formStatus: ErrorFormStatus(exception: Exception(e)));
      }
    }
  }
}
