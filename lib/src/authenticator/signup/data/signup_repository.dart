import '../../../../core/clienthttp/StatusRequest.dart';
import '../model/signup_model.dart';
import 'signup_api.dart';

class SignUpRepositoryImpl implements SignUpRepository {
  final SignUpApi api;
  SignUpRepositoryImpl({required this.api});

  @override
  Future<StatusRequest> signUp(SignUpModel model) async {
    SignUpApi api = SignUpApiImpl();

    var response = await api.signUp(model);
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

abstract class SignUpRepository {
  Future<StatusRequest> signUp(SignUpModel model);
}