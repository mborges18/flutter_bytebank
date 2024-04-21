class SignInState {
  final String email;
  final String password;
  final FormStatus formStatus;

  SignInState(
      {this.email = '',
      this.password = '',
      this.formStatus = const InitialFormStatus()});

  SignInState setEamil({required String email}) {
    return SignInState(
        email: email, password: password, formStatus: formStatus);
  }

  SignInState setPassword({
    required String password,
  }) {
    return SignInState(
        email: email, password: password, formStatus: formStatus);
  }

  SignInState setSubimitted({
    required FormStatus formStatus,
  }) {
    return SignInState(
        email: email, password: password, formStatus: formStatus);
  }
}

abstract class FormStatus {
  const FormStatus();
}

class InitialFormStatus extends FormStatus {
  const InitialFormStatus();
}

class SubimittingFormStatus extends FormStatus {}

class SuccessFormStatus extends FormStatus {}

class ErrorFormStatus extends FormStatus {
  final Exception exception;
  ErrorFormStatus({required this.exception});
}
