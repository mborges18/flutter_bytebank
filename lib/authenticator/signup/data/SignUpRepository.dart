
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../clienthttp/ClientHttp.dart';
import '../../../clienthttp/StatusRequest.dart';
import '../model/signup_model.dart';

class SignUpRepository {
  Future<StatusRequest> signUp(SignUpModel model) async {

    final response = await http.post(
      ClientHttps.setUrl('signup'),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(model.toJson()),
    );
    if(response.statusCode==201){
      return Success(response.body);
    }
    else if(response.statusCode==409){
      return Exists();
    }
    else {
      return Error(response.body);
    }
  }
}