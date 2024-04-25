import '../model/signup_model.dart';

class SignUpEvent {}

class SignUpSubmitEvent extends SignUpEvent {
  SignUpModel model;

  SignUpSubmitEvent({required this.model});
}

class SignUpSetNameEvent extends SignUpEvent {
  final String name;

  SignUpSetNameEvent({required this.name});
}

class SignUpSetBirthDateEvent extends SignUpEvent {
  final String birthDate;

  SignUpSetBirthDateEvent({required this.birthDate});
}

class SignUpSetPhoneEvent extends SignUpEvent {
  final String phone;

  SignUpSetPhoneEvent({required this.phone});
}

class SignUpSetEmailEvent extends SignUpEvent {
  final String email;

  SignUpSetEmailEvent({required this.email});
}

class SignUpSetPasswordEvent extends SignUpEvent {
  final String password;

  SignUpSetPasswordEvent({required this.password});
}

class SignUpSetPasswordConfirmEvent extends SignUpEvent {
  final String passwordConfirm;

  SignUpSetPasswordConfirmEvent({required this.passwordConfirm});
}

class SignUpEnableButtonEvent extends SignUpEvent {
  SignUpModel model;

  SignUpEnableButtonEvent({
    required this.model,
  });
}
