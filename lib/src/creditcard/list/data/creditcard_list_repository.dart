import 'dart:convert';
import '../../../../core/clienthttp/StatusRequest.dart';
import '../model/creditcard_model.dart';
import 'creditcard_list_api.dart';

class CreditCardListRepositoryImpl extends CreditCardListRepository {

  final CreditCardListApi api = CreditCardListApiImpl();

  @override
  Future<StatusRequest> getCreditCards() async {
    final response = await api.getCreditCards();
    if(response.statusCode==200){
      //final Map parsed = json.decode(res);
      //final response = HomeResponse.fromJson(parsed);
      final List parsedList = json.decode(response.body);
      List<CreditCardModel> list = parsedList.map((val) => CreditCardModel.fromJson(val)).toList();
      return Success(list);
    }
    else {
      return Error(response.body);
    }
  }

  @override
  Future<StatusRequest> deleteCreditCard(String id) async {
    final response = await api.deleteCreditCard(id);
    if(response.statusCode==200){
      return Success(true);
    } else {
      return Error(response.body);
    }
  }

  @override
  Future<StatusRequest> editCreditCard(String id) async {
    final response = await api.editCreditCard(id);
    if(response.statusCode==200){
      final Map<String, dynamic> parsed = json.decode(response.body);
      final res = CreditCardModel.fromJson(parsed);
      return Success(res);
    } else {
      return Error(response.body);
    }
  }
}

abstract class CreditCardListRepository {
  Future<StatusRequest> getCreditCards();
  Future<StatusRequest> deleteCreditCard(String id);
  Future<StatusRequest> editCreditCard(String id);
}