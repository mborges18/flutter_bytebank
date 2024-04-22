import 'package:flutter/material.dart';
import 'package:flutter_bitybank/util/theme/theme_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'authenticator/authenticator_screen.dart';
import 'package:device_preview/device_preview.dart';

import 'authenticator/signin_bloc.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => SignInBloc(),)
        ],
        child: MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        themeMode: ThemeMode.system,
        theme: lightTheme,
        darkTheme: darkTheme,
        home: const AuthenticatorScreen()),
    );
  }
}
