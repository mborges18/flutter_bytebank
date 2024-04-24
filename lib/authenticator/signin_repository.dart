import 'dart:convert';
import 'package:http/http.dart' as http;
import '../clienthttp/ClientHttp.dart';

class SignInRepository {
  Future<StatusResponse> signIn(String email, String password) async {
    var data = SignInModel(email: email, password: password);

    final response = await http.post(
      ClientHttps.setUrl('signin'),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(data.toJson()),
    );
    if(response.statusCode==200){
      return Success(response.body);
    }
    else if(response.statusCode==401){
      return Unauthorized(response.body);
    }
    else {
      return Error(response.body);
    }
  }
}

class SignInModel {
  String email;
  String password;
  SignInModel({required this.email, required this.password});

  Map toJson() => {
    'email': email,
    'password': password
  };
}

abstract class StatusResponse {}
class Success extends StatusResponse {
  Object object;
  Success(this.object);
}
class Error extends StatusResponse {
  Object object;
  Error(this.object);
}
class Exists extends StatusResponse {}
class Unauthorized extends StatusResponse {
  Object object;
  Unauthorized(this.object);
}
