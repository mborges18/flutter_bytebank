
import 'dart:convert';
import 'package:http/http.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import '../../../clienthttp/ClientHttp.dart';
import '../model/signin_model.dart';

class SignInApiImpl extends SignInApi {

  @override
  Future<Response> signIn(SignInModel data) async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var response = await http.post(
      ClientHttps.setUrl('signin'),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(data.toJson()),
    );
    return response;
  }
}

abstract class SignInApi {
  Future<Response> signIn(SignInModel date);
}