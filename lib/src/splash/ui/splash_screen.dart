import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../util/string/strings.dart';
import '../bloc/splash_bloc.dart';
import '../bloc/splash_event.dart';
import '../bloc/splash_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double letterSpacing = 15;
  double fontSize = 50;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void startTimer() {
    Future.delayed(const Duration(milliseconds: 100), (){
      setState(() {
        letterSpacing = 1;
        fontSize = 32;
      });
    });
    Future.delayed(const Duration(milliseconds: 4000), (){
      BlocProvider.of<SplashBloc>(context).add(SplashCheckIsKeepConnectEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<SplashBloc, SplashState>(
            listener: (context, state) {
              (state is SplashYesKeepConnectState)
                  ? Navigator.pushNamed(context, '/list')
                  : (state is SplashNotKeepConnectState)
                  ? Navigator.pushNamed(context, '/auth')
                  : {} ;
            },
            builder: (context, state) {
              return Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Theme.of(context).colorScheme.primary,
                  child:
                      Stack(alignment: AlignmentDirectional.center, children: [
                    AnimatedDefaultTextStyle(
                      style: TextStyle(
                        letterSpacing: letterSpacing,
                        height: 0,
                        fontWeight: FontWeight.bold,
                        fontSize: fontSize,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      duration: const Duration(milliseconds: 500),
                      child: const Text(titleApp),
                    ),
                  ]));
            }));
  }
}
