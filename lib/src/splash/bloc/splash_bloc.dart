
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/splash_repository.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {

  SplashBloc(SplashRepository repository): super(SplashInitialState()) {
    on<SplashCheckIsKeepConnectEvent>((event, emit) async {
      var response = await repository.checkIsKeepConnect();
      response == true
          ? emit(SplashYesKeepConnectState())
          : emit(SplashNotKeepConnectState());
    });
  }
}