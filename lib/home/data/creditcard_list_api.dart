
import 'package:flutter_bitybank/clienthttp/ClientHttp.dart';
import 'package:http/http.dart';

class CreditCardListApiImpl implements CreditCardListApi {

  @override
  Future<Response> getCreditCards() async {
    var response = ClientHttps().get('cards');
    return response;
  }

  @override
  Future<Response> deleteCreditCard(String id) async {
    var response = ClientHttps().delete('cards/$id');
    return response;
  }

  @override
  Future<Response> editCreditCard(String id) async {
    var response = ClientHttps().get('cards/$id');
    return response;
  }
}

abstract class CreditCardListApi {
  Future<Response> getCreditCards();
  Future<Response> deleteCreditCard(String id);
  Future<Response> editCreditCard(String id);
}