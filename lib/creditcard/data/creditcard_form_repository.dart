
import 'dart:convert';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import '../../../clienthttp/ClientHttp.dart';
import '../../../clienthttp/StatusRequest.dart';
import '../model/creditcard_form_model.dart';


class CreditCardFormRepository {
  Future<StatusRequest> register(CreditCardFormModel model) async {

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    final response = await http.post(
      ClientHttps.setUrl('cards'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'X-Auth-Token': 'xhjXi2YSrWVQ03c2johE3er4U3Cud24k5AzFUljrfm9LYC2YhykbJdGepiDIZwzJ.creditcard'
      },
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