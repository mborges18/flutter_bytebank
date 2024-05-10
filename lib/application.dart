import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bitybank/util/theme/theme_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'di/modules.dart';
import 'src/authenticator/authenticator_screen.dart';
import 'src/authenticator/signin/bloc/signin_bloc.dart';
import 'src/authenticator/signup/bloc/signup_bloc.dart';
import 'src/creditcard/form/bloc/creditcard_form_bloc.dart';
import 'src/creditcard/form/ui/creditcard_form_screen.dart';
import 'src/creditcard/list/bloc/creditcard_list_bloc.dart';
import 'src/creditcard/list/ui/creditcard_list_screen.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return ModularApp(
      module: Modules(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => Modular.get<SignInBloc>()),
          BlocProvider(create: (context) => SignUpBloc()),
          BlocProvider(create: (context) => CreditCardListBloc()),
          BlocProvider(create: (context) => CreditCardFormBloc()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            themeMode: ThemeMode.system,
            theme: lightTheme,
            darkTheme: darkTheme,
            initialRoute: '/',
            routes: {
              '/': (context) => const AuthenticatorScreen(),
              '/list': (context) => const CreditCardListScreen(),
              '/form': (context) => const CreditCardFormScreen(),
            },
        ),
      ),
    );
  }
}
