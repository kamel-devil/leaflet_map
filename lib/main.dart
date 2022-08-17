
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import 'package:map_app/provider/provider.dart';
import 'package:map_app/splash_screen.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<func_provider>(
      create: (context)=>func_provider()..data_mark('1')..data_map('0'),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Splash()
        // AnimatedSplashScreen(
        //     splash: icon:Icon(Icons.home)
        //
        //     duration:2000,
        //     nextScreen: MyHomePage(title: 'map',)),
      ),
    );
  }
}

