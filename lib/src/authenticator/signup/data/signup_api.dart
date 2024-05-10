import 'package:http/http.dart';
import '../../../../core/clienthttp/ClientHttp.dart';
import '../model/signup_model.dart';

class SignUpApiImpl implements SignUpApi {

  @override
  Future<Response> signUp(data) async {
    var response = await ClientHttps().post('signup', data);
    return response;
  }
}

abstract class SignUpApi {
  Future<Response> signUp(SignUpModel data);
}
