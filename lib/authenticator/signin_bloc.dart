import 'package:flutter_bitybank/authenticator/signin_event.dart';
import 'package:flutter_bitybank/authenticator/signin_repository.dart';
import 'package:flutter_bitybank/authenticator/signin_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final repository = SignInRepository();

  SignInBloc() : super(SignInStateInitial()) {
    on<SignInEvent>((event, emit) async {
      if (event is SignIn) {
        emit(SignInStateLoading());
        try {
          var response = await repository.signIns(event.email, event.password);
          emit(SignInStateSuccess(response));
        } catch(error) {
          emit(SignInStateError(error));
        }
      }
    });
  }
}
