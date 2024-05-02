import 'package:flutter/material.dart';
import 'package:flutter_bitybank/util/theme/theme_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'authenticator/authenticator_screen.dart';
import 'package:device_preview/device_preview.dart';

import 'authenticator/signin/bloc/signin_bloc.dart';
import 'authenticator/signup/bloc/signup_bloc.dart';
import 'creditcard/bloc/creditcard_form_bloc.dart';
import 'creditcard/ui/creditcard_form_screen.dart';
import 'home/ui/home_screen.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => SignInBloc()),
          BlocProvider(create: (context) => SignUpBloc()),
          BlocProvider(create: (context) => CreditCardFormBloc()),
        ],
        child: MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        themeMode: ThemeMode.system,
        theme: lightTheme,
        darkTheme: darkTheme,
        home: const CreditCardFormScreen()),
    );
  }
}
