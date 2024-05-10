import 'package:flutter_modular/flutter_modular.dart';
import '../src/authenticator/signin/bloc/signin_bloc.dart';
import '../src/authenticator/signin/data/signin_api.dart';
import '../src/authenticator/signin/data/signin_repository.dart';

class Modules extends Module {

  @override
  void binds(i) {
    i.addSingleton(SignInBloc.new);
    i.add<SignInRepository>(SignInRepositoryImpl.new);
    i.add<SignInApi>(SignInApiImpl.new);
  }
}
