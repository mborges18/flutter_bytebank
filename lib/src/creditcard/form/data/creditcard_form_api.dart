import 'package:http/http.dart';
import '../../../../core/clienthttp/ClientHttp.dart';
import '../model/creditcard_form_model.dart';

class CreditCardFormApiImpl extends CreditCardFormApi {

  @override
  Future<Response> create(CreditCardFormModel data) async {
    var response = await ClientHttps().post('cards', data);
    return response;
  }

  @override
  Future<Response> update(CreditCardFormModel data) async {
    var response = await ClientHttps().put('cards', data);
    return response;
  }
}

abstract class CreditCardFormApi {
  Future<Response> create(CreditCardFormModel data);
  Future<Response> update(CreditCardFormModel data);
}