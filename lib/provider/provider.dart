import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:latlong2/latlong.dart';

class func_provider with ChangeNotifier {
  List<Marker> mark = [];
  List loc = [];
  List cate = [];

  void data_map(String id) async {
    var D = await get(Uri.parse(
        'https://ibtikarsoft.net/mapapi/categories.php?lang=ar&cat=$id'));
    if (D.statusCode == 200) {
      var x = json.decode(D.body);

      cate = x;
    }
    notifyListeners();
  }

  data_mark(String id) async {
    String url =
        'https://ibtikarsoft.net/mapapi/map_markers.php?lang=ar&lat=30.0374562&long=31.2095052&cat=$id';
    final res = await get(Uri.parse(url)).then((value) {
      print(value.body);
      if (value.statusCode == 200) {
        var data = json.decode(value.body);
        loc = data;
        print('-----------------------------');
        print(loc);
        mark.clear();
        loc.forEach((element) {
          mark.add(Marker(
            width: 50,
            height: 50,
            point: LatLng(
                double.parse(element['lat']), double.parse(element['long'])),
            builder: (ctx) => InkWell(
              child: Icon(
                IconDataSolid(int.parse(element['icon_name'])),
                // color: HexColor.fromHex(element['color']),
                size: 25.0,
              ),
              onTap: () {
                showModalBottomSheet(
                    context: ctx,
                    builder: (builder) {
                      return Container(
                        height: 350.0,
                        color: Colors.transparent,
                        //could change this to Color(0xFF737373),
                        //so you don't have to change MaterialApp canvasColor
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0))),
                        ),
                      );
                    });
              },
            ),
          ));
        });
        print('----------');
        print(mark);
        print('----------');
        notifyListeners();

        print(data);
      }
    });

    // if (res.statusCode == 200) {
    //   var data = json.decode(res.body);
    //   for (int i in data) {
    //     location = data;
    //     print(data);
    //     markers.add(Marker(
    //       point: LatLng(
    //           double.parse(data[i]['lat']), double.parse(data[i]['long'])),
    //       builder: (ctx) => Container(
    //         key: const Key('blue'),
    //         child: const Icon(
    //           Icons.location_on,
    //           color: Colors.red,
    //           size: 30.0,
    //         ),
    //       ),
    //     ));
    //
    //     print(markers);
    //     notifyListeners();
    //     print('----------------');
    //     print(data);
    //     print('----------------------');
    //     return data;
    //   }
    // } else {
    //   print("Error");
    // }
  }}
