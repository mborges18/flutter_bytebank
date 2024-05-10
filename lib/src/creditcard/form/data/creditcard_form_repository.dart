import 'dart:convert';
import '../../../../core/clienthttp/StatusRequest.dart';
import '../model/creditcard_form_model.dart';
import 'creditcard_form_api.dart';

class CreditCardFormRepositoryImpl implements CreditCardFormRepository {

  final CreditCardFormApi api = CreditCardFormApiImpl();

  Future<StatusRequest> create(CreditCardFormModel model) async {
    var response = await api.create(model);

    if(response.statusCode==201){
      final map = json.decode(response.body) as Map<String, dynamic>;
      final model = CreditCardFormModel.fromJson(map);
      return Success(model);
    }
    else if(response.statusCode==409){
      return Exists();
    }
    else {
      return Error(response.body);
    }
  }

  Future<StatusRequest> update(CreditCardFormModel model) async {
    var response = await api.update(model);

    if(response.statusCode==200){
      final map = json.decode(response.body) as Map<String, dynamic>;
      final model = CreditCardFormModel.fromJson(map);
      return Success(model);
    }
    else if(response.statusCode==409){
      return Exists();
    }
    else {
      return Error(response.body);
    }
  }
}

abstract class CreditCardFormRepository {
  Future<StatusRequest> create(CreditCardFormModel model);
  Future<StatusRequest> update(CreditCardFormModel model);
}