
import 'dart:convert';

import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../clienthttp/ClientHttp.dart';
import '../../clienthttp/StatusRequest.dart';
import '../../util/string/strings.dart';
import '../model/creditcard_model.dart';

class HomeRepositoryImpl extends HomeRepository {

  @override
  Future<StatusRequest> getCreditCards() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var idUser = jsonDecode(prefs.getString(userID) ?? "");

    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    final response = await http.get(
      ClientHttps.setUrl('cards'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'X-Auth-Token': 'xhjXi2YSrWVQ03c2johE3er4U3Cud24k5AzFUljrfm9LYC2YhykbJdGepiDIZwzJ.creditcard',
        'idUser': idUser.toString()
      },
    );

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
}

abstract class HomeRepository {
  Future<StatusRequest> getCreditCards();
}