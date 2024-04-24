
class SignInModel {
  String email;
  String password;
  SignInModel({required this.email, required this.password});

  Map toJson() => {
    'email': email,
    'password': password
  };
}
