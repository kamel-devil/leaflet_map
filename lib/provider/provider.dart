import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:latlong2/latlong.dart';

import '../tools/color_data.dart';

class Funcprovider with ChangeNotifier {
  List<Marker> mark = [];
  List loc = [];
  List cate = [];
  List sliderData = [];
  double? lat;
  double? long;
  bool result=false;

  void dataMap(String id) async {
    var D = await get(Uri.parse(
        'https://ibtikarsoft.net/mapapi/categories.php?lang=ar&cat=$id'));
    if (D.statusCode == 200) {
      var x = json.decode(D.body);

      cate = x;
    }
    notifyListeners();
  }

  dataMark(String id,
      double lat,
      double long
      ) async {
    String url =
        'https://ibtikarsoft.net/mapapi/map_markers.php?lang=ar&lat=$lat&long=$long&cat=$id';
        // 'https://ibtikarsoft.net/mapapi/map_markers.php?lang=ar&lat=30.0374562&long=31.2095052&cat=$id';
     await get(Uri.parse(url)).then((value) {
      // print(value.body);
      if (value.statusCode == 200) {
        var data = json.decode(value.body);
        loc = data;
        // print('-----------------------------');
        // print(loc);
        mark.clear();
        for (var element in loc) {
          mark.add(Marker(
            width: 50,
            height: 50,
            point: LatLng(
                double.parse(element['lat']), double.parse(element['long'])),
            builder: (ctx) => InkWell(
              child: Icon(
                IconDataSolid(int.parse(element['icon_name'])),
                 color: HexColor.fromHex(element['color']),
                size: 25.0,
              ),
              onTap: () {

              },
            ),
          ));
        }
        mark.add(Marker(
          width: 50,
          height: 50,
          point: LatLng(
              lat, long),
          builder: (ctx) => const Icon(
            FontAwesomeIcons.locationDot,
            color: Colors.redAccent,
            size: 35.0,
          ),
        ));
        // print('----------');
        // print(mark);
        // print('----------');
        notifyListeners();

        // print(data);
      }
    });

  }
  dataSlider(String id) async {
    String url =
        'https://ibtikarsoft.net/mapapi/map_slider.php?lang=ar&lat=$lat&long=$long&cat=$id';
    // 'https://ibtikarsoft.net/mapapi/map_slider.php?lang=ar&lat=30.0374562&long=31.2095052&cat=$id';

    final res = await get(Uri.parse(url));

    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      sliderData = data;
      // print('=====================================');
      // print(sliderData);
      notifyListeners();
      return data;
    } else {
      print("Error");
    }
  }
  Future<Position?> getCheckLocation() async {
    Geolocator.checkPermission().then((value){
      print(value);
      if (value ==LocationPermission.denied){
        Geolocator.requestPermission().then((value) {
          if (value==LocationPermission.denied){
            print("denied");
          }
          else if(value==LocationPermission.whileInUse){
            print('go ');
            getCurrentLocation();
            notifyListeners();
          }else{
          }
        });
      }
      else {
        getCurrentLocation();
      }
    });
    notifyListeners();
    return null;
  }
  Future<Position?> getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    Position? lastPsition = await Geolocator.getLastKnownPosition();
    print('------------------------**-----------**--------');
    print(lastPsition?.latitude);
    print(lastPsition?.longitude);
    lat=lastPsition!.latitude;
    long=lastPsition.longitude;
    dataMark('0', lat!, long!);
    dataMap('0');
    dataSlider('0');
    notifyListeners();
    return lastPsition;
    // locationMessage="$position.latitude ,$position.longitude";
  }
  checkEnternet()async{
    bool result1 = await InternetConnectionChecker().hasConnection;
    if(result1 == true) {
      print('Connection Done');
    } else {

      print('Connection failed');
    }

    result=result1;
    notifyListeners();
  }

}
