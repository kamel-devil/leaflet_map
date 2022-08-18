import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_app/provider/provider.dart';
import 'package:provider/provider.dart';

import 'helper_location.dart';
import 'map.dart';
class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  // Timer? _time;
  //
  // _startDelay() {
  //   _time = Timer(const Duration(seconds: 2), _goNext);
  // }
  //
  // _goNext() {
  //   Navigator.pushReplacement(
  //       context, MaterialPageRoute(builder: (context) =>  MyHomePage()));
  // }
  @override
  void initState() {
     LocationHelper.checkEnternet();
     LocationHelper.getCheckLocation();
     // _startDelay();
     _navigatetohome();
     super.initState();
  }
  _navigatetohome(){
     Future.delayed(const Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MyHomePage()));

    });
  }
  @override
  Widget build(BuildContext context) {
    print(Provider.of<func_provider>(context).loc);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
                image: AssetImage('assets/background.png')
            )
        ),

        child: Padding(
          padding: const EdgeInsets.only(top: 550),
          child: Column(
            children: [
               const Text('Welcome to Map'
                   ,style:  TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
               ),
              const SizedBox(height: 10,),
              const Text('Find your perfect place'),
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.center,
                // decoration: InputDecoration(
                //   border: OutlineInputBorder(
                //     borderRadius: BorderRadius.circular(45),
                //   borderSide:
                //   const BorderSide(color: Colors.black, width: 1.2)),
                // ),
                height: 50,
                width: 200,
                child: ElevatedButton( onPressed: () { },

              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFfb7750)),
                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),))
                 ),
                    // ElevatedButton.styleFrom(
                    //   primary:const Color(0xFFfb7750)),
                    child: const Text('Lets Go',style:  TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                  // color: Color(0xFFfb7750),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('App UI template with Google Map Complete Detail Address')

            ],
          ),
        ),
      ),
    );
  }

}
