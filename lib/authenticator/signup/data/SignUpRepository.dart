
import 'dart:convert';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import '../../../clienthttp/ClientHttp.dart';
import '../../../clienthttp/StatusRequest.dart';
import '../model/signup_model.dart';

class SignUpRepository {
  Future<StatusRequest> signUp(SignUpModel model) async {

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
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