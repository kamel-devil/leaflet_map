
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:map_app/provider/provider.dart';
import 'package:map_app/screen/info_mark.dart';
import 'package:map_app/screen/splash_screen.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Funcprovider>(
      create: (context)=>Funcprovider()..dataMark('0')..dataMap('0')..dataSlider('0')..getCheckLocation()..getCurrentLocation()..checkEnternet(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:
        // const Splash()
        AnimatedSplashScreen(
            splash:FontAwesomeIcons.mapLocationDot,
            duration:3000,
            splashTransition: SplashTransition.scaleTransition,
            backgroundColor: Color(0xFF414171),

            nextScreen:Splash(),

      ),
    ));
  }
}

