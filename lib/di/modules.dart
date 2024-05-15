import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../src/authenticator/signin/bloc/signin_bloc.dart';
import '../src/authenticator/signin/data/signin_api.dart';
import '../src/authenticator/signin/data/signin_repository.dart';
import '../src/authenticator/signup/bloc/signup_bloc.dart';
import '../src/authenticator/signup/data/signup_api.dart';
import '../src/authenticator/signup/data/signup_repository.dart';
import '../src/creditcard/form/bloc/creditcard_form_bloc.dart';
import '../src/creditcard/form/data/creditcard_form_api.dart';
import '../src/creditcard/form/data/creditcard_form_repository.dart';
import '../src/creditcard/list/bloc/creditcard_list_bloc.dart';
import '../src/creditcard/list/data/creditcard_list_api.dart';
import '../src/creditcard/list/data/creditcard_list_repository.dart';
import '../src/splash/bloc/splash_bloc.dart';
import '../src/splash/data/splash_repository.dart';

class Modules extends Module {

  @override
  void binds(i) {
    ///Splash
    i.addSingleton(SplashBloc.new);
    i.add<SplashRepository>(SplashRepositoryImpl.new);
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
    i.add<CreditCardListRepository>(CreditCardListRepositoryImpl.new);
    i.add<CreditCardListApi>(CreditCardListApiImpl.new);
    ///Form
    i.addSingleton(CreditCardFormBloc.new);
    i.add<CreditCardFormRepository>(CreditCardFormRepositoryImpl.new);
    i.add<CreditCardFormApi>(CreditCardFormApiImpl.new);
  }
}
