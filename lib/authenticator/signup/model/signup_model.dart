
class SignUpModel {
  String name;
  String birthDate;
  String phone;
  String email;
  String password;
  String passwordConfirm;

  SignUpModel({
    required this.name,
    required this.birthDate,
    required this.phone,
    required this.email,
    required this.password,
    required this.passwordConfirm,
  });

  Map toJson() => {
        'name': name,
        'birthDate': birthDate,
        'phone': phone,
        'email': email,
        'password': password,
      };
}
