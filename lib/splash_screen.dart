import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:latlong2/latlong.dart';

import 'helper_location.dart';
import 'map.dart';
class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    data_mark('1');
    LocationHelper.checkEnternet();
    LocationHelper.getCheckLocation();
    super.initState();
    _navigatetohome();
  }
  _navigatetohome()async{
    await Future.delayed(const Duration(milliseconds: 3000),(){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MyHomePage(loc:loc,mark:mark,)));
  }

  List<Marker> mark = [];
  List loc = [];
  @override
  Widget build(BuildContext context) {
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

  Future<List<Marker>> data_mark(String id) async {
    var D = await get(Uri.parse(
        'https://ibtikarsoft.net/mapapi/map_markers.php?lang=ar&lat=30.0374562&long=31.2095052&cat=$id'));
    if (D.statusCode == 200) {
      var x = await json.decode(D.body);
      setState(() {
        loc = x;
        loc.forEach((element) {
          mark.add(
            Marker(
                anchorPos: AnchorPos.align(AnchorAlign.center),
                height: 30,
                width: 30,
                point: LatLng(double.parse(element['lat']),
                    double.parse(element['long'])),
                builder: (context) => const Icon(
                  FontAwesomeIcons.houseMedical,
                  color: Colors.red,
                  size: 20,
                )),
          );
          print(mark);
        });
        print(mark);
        print(loc);
      });
    }
    return mark;
  }
}
