
import 'dart:convert';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import '../../../clienthttp/ClientHttp.dart';
import '../../../clienthttp/StatusRequest.dart';
import '../model/signin_model.dart';

class SignInRepository {
  Future<StatusRequest> signIn(String email, String password) async {
    var data = SignInModel(email: email, password: password);

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
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
