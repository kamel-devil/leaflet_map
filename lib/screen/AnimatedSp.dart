import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:map_app/screen/splash_screen.dart';

class Animatedsp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return AnimatedSplashScreen(
        splash: FontAwesomeIcons.mapLocationDot,
        duration: 3000,
        splashTransition: SplashTransition.scaleTransition,
        backgroundColor: Color(0xFF414171),
        nextScreen: Splash(),

      );
    }
}
