
import 'package:http/http.dart';
import '../../../../core/clienthttp/ClientHttp.dart';
import '../model/signin_model.dart';

class SignInApiImpl extends SignInApi {

  @override
  Future<Response> signIn(SignInModel data) async {
    var response = await ClientHttps().post('signin', data);
    return response;
  }
}

abstract class SignInApi {
  Future<Response> signIn(SignInModel data);
}