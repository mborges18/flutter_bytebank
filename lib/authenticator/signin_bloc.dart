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
          var response = await repository.signIn(event.email, event.password);
          if((response is Success)) {
            emit(SignInStateSuccess(response.object.toString()));
          } else if(response is Unauthorized) {
            emit(SignInStateUnauthorized(response.object));
          } else {
            emit(SignInStateError((response as Error).object));
          }
        } catch(error) {
          emit(SignInStateError(error));
        }
      }
    });
  }
}
