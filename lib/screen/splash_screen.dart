import 'dart:async';
import 'package:flutter/material.dart';
import 'package:map_app/provider/provider.dart';
import 'package:provider/provider.dart';
import 'map.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
     _navigatetohome();
     super.initState();
  }
  _navigatetohome(){
     Future.delayed(const Duration(seconds: 2),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const MyHomePage()));

    });
  }
  @override
  Widget build(BuildContext context) {
     print(Provider.of<Funcprovider>(context).loc);
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
                height: 50,
                width: 200,
                child: ElevatedButton( onPressed: () { },

              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFfb7750)),
                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),))
                 ),

                    child: const Text('Lets Go',style:  TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
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
