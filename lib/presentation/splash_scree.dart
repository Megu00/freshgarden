import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';

import 'package:fresh_garden/presentation/signup_screen.dart';
class SplashScreeen extends StatelessWidget {
  const SplashScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
          backgroundImage: Image.asset("assets/fresh_garden.png"),
          childWidget:  const Center(
            child: CircularProgressIndicator(
            color: Colors.white,
          )),
          defaultNextScreen: const SignupScreen(),
        );
  }
}