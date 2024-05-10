import 'package:flutter_modular/flutter_modular.dart';
import '../src/authenticator/signin/bloc/signin_bloc.dart';
import '../src/authenticator/signin/data/signin_api.dart';
import '../src/authenticator/signin/data/signin_repository.dart';
import '../src/authenticator/signup/bloc/signup_bloc.dart';
import '../src/authenticator/signup/data/signup_api.dart';
import '../src/authenticator/signup/data/signup_repository.dart';
import '../src/creditcard/form/bloc/creditcard_form_bloc.dart';
import '../src/creditcard/list/bloc/creditcard_list_bloc.dart';

class Modules extends Module {

  @override
  void binds(i) {
    ///SignIn
    i.addSingleton(SignInBloc.new);
    i.add<SignInRepository>(SignInRepositoryImpl.new);
    i.add<SignInApi>(SignInApiImpl.new);
    ///SignUp
    i.addSingleton(SignUpBloc.new);
    i.add<SignUpRepository>(SignUpRepositoryImpl.new);
    i.add<SignUpApi>(SignUpApiImpl.new);
    ///List
    i.addSingleton(CreditCardListBloc.new);
    ///Form
    i.addSingleton(CreditCardFormBloc.new);
  }
}
