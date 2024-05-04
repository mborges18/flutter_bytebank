import 'package:flutter_bitybank/authenticator/signin/bloc/signin_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../authenticator/signin/data/signin_repository.dart';

class Modules extends Module {

  @override
  List<Bind> get binds => [
    Bind.singleton((i) => SignInBloc(i.get())),
    Bind.singleton(<SignInRepository>(i) => SignInRepositoryImpl()),
  ];
}
