import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/clienthttp/StatusRequest.dart';
import '../../../../util/date/dates_util.dart';
import '../../../../util/string/strings.dart';
import '../../../../util/validator/validator.dart';
import '../data/signup_repository.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {

  SignUpBloc(
    SignUpRepository repository,
  ) : super(SignUpStateInitial()) {

    on<SignUpEnableButtonEvent>((event, emit) async {
      var isEnabled = event.model.name.length > 2 &&
          event.model.birthDate.length == 10 &&
          event.model.phone.length == 15 &&
          event.model.email.length > 5 &&
          event.model.password.length > 5 &&
          event.model.passwordConfirm.length > 5;
          emit(SignUpStateButton(isEnabled));
    });

    on<SignUpSetNameEvent>((event, emit) async {
      ///Validation name could be here
      emit(SignUpStateName(null));
    });

    on<SignUpSetBirthDateEvent>((event, emit) async {
      ///Validation birthDate could be here
      emit(SignUpStateBirthDate(null));
    });

    on<SignUpSetPhoneEvent>((event, emit) async {
      ///Validation phone could be here
      emit(SignUpStatePhone(null));
    });

    on<SignUpSetEmailEvent>((event, emit) async {
      ///Validation email could be here
      emit(SignUpStateEmail(null));
    });

    on<SignUpSetPasswordEvent>((event, emit) async {
      ///Validation password could be here
      emit(SignUpStatePassword(null));
    });

    on<SignUpSetPasswordConfirmEvent>((event, emit) async {
      ///Validation passwordConfirm could be here
      emit(SignUpStatePasswordConfirm(null));
    });

    on<SignUpSubmitEvent>((event, emit) async {
      ///Validation is be done when form is submitted
      bool isValid = true;
      if (event.model.name.split(" ").length < 2) {
        isValid = false;
        emit(SignUpStateName(msgNameInvalid));
      }
      if (!Validator.isValidEmail(event.model.email)) {
        isValid = false;
        emit(SignUpStateEmail(msgEmailInvalid));
      }
      if (!DatesUtil.isValidBirthDate(event.model.birthDate)) {
        isValid = false;
        emit(SignUpStateBirthDate(msgDateInvalid));
      }
      if (!event.model.phone.split(" ")[1].startsWith("9")) {
        isValid = false;
        emit(SignUpStatePhone(msgPhoneInvalid));
      }
      if (event.model.passwordConfirm != event.model.password) {
        isValid = false;
        emit(SignUpStatePasswordConfirm(msgPasswordDifferent));
      }

      if(isValid) {
        try {
          emit(SignUpStateLoading());
          var response = await repository.signUp(event.model);
          debugPrint("SignUpBloc - $response");
          if ((response is Success)) {
            emit(SignUpStateSuccess(response.object.toString()));
          } else if (response is Exists) {
            emit(SignUpStateEmail(msgEmailExists));
          } else {
            emit(SignUpStateError((response as Error).object));
          }
        } catch (error) {
          emit(SignUpStateError(error));
        }
      }
    });
  }
}
