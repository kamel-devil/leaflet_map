// for get current location

import 'package:geolocator/geolocator.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class LocationHelper {
  static Future<Position?> getCheckLocation() async {
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
          }else{
            getCurrentLocation();
          }
        });
      }
    });
  }
  static Future<Position?> getCurrentLocation() async{
    await Geolocator.getCurrentPosition(desiredAccuracy:LocationAccuracy.high);
    var lastPsition = await Geolocator.getLastKnownPosition();
    return lastPsition;
    // locationMessage="$position.latitude ,$position.longitude";



  }

  static checkEnternet()async{
    bool result = await InternetConnectionChecker().hasConnection;
    if(result == true) {
      print('Connection Done');
    } else {
      print('Connection failed');
    }
  }
}

