
abstract class SignInState {}
class SignInStateInitial extends SignInState {}
class SignInStateLoading extends SignInState {}
class SignInStateSuccess extends SignInState {
  String value;
  SignInStateSuccess(this.value);
}
class SignInStateError extends SignInState {
  Object object;
  SignInStateError(this.object);
}
class SignInStateUnauthorized extends SignInState {
  Object object;
  SignInStateUnauthorized(this.object);
}
