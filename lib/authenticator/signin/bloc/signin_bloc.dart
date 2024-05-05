import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../clienthttp/StatusRequest.dart';
import '../../../util/string/strings.dart';
import '../../../util/validator/validator.dart';
import '../data/signin_repository.dart';
import 'signin_event.dart';
import 'signin_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {

  SignInBloc(SignInRepository repository): super(SignInStateInitial()) {

    on<SignInEnableButtonEvent>((event, emit) async {
      var isEnabled = event.email.length > 5 && event.password.length > 5;
      emit(SignInStateButton(isEnabled));
    });

    on<SignInSetEmailEvent>((event, emit) async {
      ///Validation email could be here
      emit(SignInStateEmail(null));
    });

    on<SignInSetPasswordEvent>((event, emit) async {
      ///Validation password could be here
      emit(SignInStatePassword(null));
    });

    on<SignInSubmitEvent>((event, emit) async {
      ///Validation is be done when form is submitted
      if (!Validator.isValidEmail(event.email)) {
        emit(SignInStateEmail(msgEmailInvalid));
      }
      if (Validator.isValidEmail(event.email) && event.password.length > 5) {
        emit(SignInStateEmail(null));
        emit(SignInStatePassword(null));
        emit(SignInStateLoading());
        try {
          var response = await repository.signIn(event.email, event.password);
          if (response is Success) {
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString(userID, response.object.toString());
            emit(SignInStateSuccess(response.object.toString()));
          } else if (response is Unauthorized) {
            emit(SignInStateEmail(msgEmailUnauthorized));
            emit(SignInStatePassword(msgPasswordUnauthorized));
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
