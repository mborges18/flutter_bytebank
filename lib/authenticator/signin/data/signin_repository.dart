
import '../../../clienthttp/StatusRequest.dart';
import '../model/signin_model.dart';
import 'signin_api.dart';

class SignInRepositoryImpl implements SignInRepository {
  final SignInApi api;
  SignInRepositoryImpl({required this.api});

  @override
  Future<StatusRequest> signIn(String email, String password) async {
    var data = SignInModel(email: email, password: password);

    var response = await api.signIn(data);
    if(response.statusCode==200){
      return Success(response.body.toString());
    }
    else if(response.statusCode==401){
      return Unauthorized(response.body);
    }
    else {
      return Error(response.body);
    }
  }
}

abstract class SignInRepository {
  Future<StatusRequest> signIn(String email, String password);
}
