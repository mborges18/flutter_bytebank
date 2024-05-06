
import '../../../util/date/dates_util.dart';

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
        "name": name,
        "birthDate": DatesUtil.toAmericanDate(date: birthDate),
        "phone": phone,
        "email": email,
        "password": password,
        "type": "GOLD",
        "status": "ACTIVE",
      };
}
