import 'dart:convert';
import '../../../../core/clienthttp/StatusRequest.dart';
import '../model/creditcard_form_model.dart';
import 'creditcard_form_api.dart';

class CreditCardFormRepositoryImpl implements CreditCardFormRepository {
  final CreditCardFormApi api;
  CreditCardFormRepositoryImpl(this.api);

  @override
  Future<StatusRequest> create(CreditCardFormModel data) async {
    var response = await api.create(data);

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

  @override
  Future<StatusRequest> update(CreditCardFormModel data) async {
    var response = await api.update(data);

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
  Future<StatusRequest> create(CreditCardFormModel data);
  Future<StatusRequest> update(CreditCardFormModel data);
}