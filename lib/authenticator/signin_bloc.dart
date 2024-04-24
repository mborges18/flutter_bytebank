import 'package:flutter_bitybank/authenticator/signin_event.dart';
import 'package:flutter_bitybank/authenticator/signin_repository.dart';
import 'package:flutter_bitybank/authenticator/signin_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../util/validator/validator.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final repository = SignInRepository();

  SignInBloc() : super(SignInStateInitial()) {

    on<SignInEnableButtonEvent>((event, emit) async {
      var isEnabled = event.email.length > 5 && event.password.length > 5;
      emit(SignInStateButton(isEnabled));
    });

    on<SignInSetEmailEvent>((event, emit) async {
      //Validation email could be here
      emit(SignInStateEmail(null));
    });

    on<SignInSetPasswordEvent>((event, emit) async {
      //Validation password could be here
      emit(SignInStatePassword(null));
    });

    on<SignInSubmitEvent>((event, emit) async {
      //Validation is be done when form is submitted
      if (!Validator.isValidEmail(event.email)) {
        emit(SignInStateEmail("E-mail inválido"));
      }
      if (event.password.length < 5) {
        emit(SignInStatePassword("Senha inválida"));
      }
      if (Validator.isValidEmail(event.email) && event.password.length > 5) {
        emit(SignInStateEmail(null));
        emit(SignInStatePassword(null));
        emit(SignInStateLoading());
        try {
          var response = await repository.signIn(event.email, event.password);
          if ((response is Success)) {
            emit(SignInStateSuccess(response.object.toString()));
          } else if (response is Unauthorized) {
            // emit(SignInStateField(
            //     SignInStateEmail("Seu e-mail pode estar errado"),
            //     SignInStatePassword("Sua senha pode estar errada")
            // ));
            emit(SignInStateEmail("Seu e-mail pode estar errado"));
            emit(SignInStatePassword("Sua senha pode estar errada"));
          } else {
            emit(SignInStateError((response as Error).object));
          }
        } catch (error) {
          emit(SignInStateError(error));
        }
      }
    });
  }
}
