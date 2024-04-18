import 'package:flutter/material.dart';

import 'auth/authenticator_screen.dart';
import 'package:device_preview/device_preview.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        theme: ThemeData(
            useMaterial3: false,
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
            primaryColor: const Color(0xFF023B8F)),
        darkTheme: ThemeData.dark(),
        home: const AuthenticatorScreen());
  }
}
