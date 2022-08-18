import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_app/provider/provider.dart';
import 'package:map_app/to_map.dart';
import 'package:provider/provider.dart';

import 'carouselslider.dart';
import 'color_data.dart';
import 'helper_location.dart';

class MyHomePage extends StatefulWidget {


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double? lat;

  double? long;

  final PopupController _popupController = PopupController();
  //
  // final List<String> imgList = [
  //   'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  //   'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  //   'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  // ];

  @override
  Widget build(BuildContext context) {
    var pro=Provider.of<func_provider>(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Map'),
      //   backgroundColor: Colors.black87,
      //   centerTitle: true,
      // ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.black,
      //   child: const Icon(Icons.refresh),
      //   onPressed: () {
      //     pointIndex++;
      //     if (pointIndex >= points.length) {
      //       pointIndex = 0;
      //     }
      //     setState(() {
      //       markers[0] = Marker(
      //           point: points[pointIndex],
      //           anchorPos: AnchorPos.align(AnchorAlign.center),
      //           height: 30,
      //           width: 30,
      //           builder: (ctx) => const Icon(Icons.pin_drop));
      //       markers = List.from(markers);
      //     });
      //   },
      // ),
      body: Stack(children: [
        FlutterMap(
          options: MapOptions(
            center: LatLng(30.0374562, 31.2095052)
            ,
            zoom: 12,
            plugins: [
              MarkerClusterPlugin(),
            ],
            onTap: (_, i) => _popupController.hideAllPopups(),
          ),
          layers: [
            TileLayerOptions(
              maxZoom: 22,
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerClusterLayerOptions(
              maxClusterRadius: 120,
              disableClusteringAtZoom: 6,
              size: const Size(40, 40),
              anchor: AnchorPos.align(AnchorAlign.center),
              fitBoundsOptions:
                  const FitBoundsOptions(padding: EdgeInsets.all(50)),
              markers: pro.mark,
              popupOptions: PopupOptions(
                popupSnap: PopupSnap.markerTop,
                popupController: _popupController,
                popupBuilder: (_, maker) => Container(
                  width: 200,
                  height: 100,
                  color: Colors.white,
                  child: GestureDetector(
                    onTap: () => debugPrint('Popup tap!'),
                    child: Text('Container popup for marker at '),
                  ),
                ),
              ),
              builder: (context, markers) {
                return FloatingActionButton(
                    onPressed: null, child: Text(markers.length.toString()));
              },
            )
          ],
        ),

        Container(
          height: 250,
          padding: const EdgeInsets.symmetric(vertical: 64.0, horizontal: 16.0),
          // height: 120,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45),
                      borderSide: const BorderSide(
                          color: Color(0xFFfb7750), width: 1.2)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45),
                      borderSide: const BorderSide(
                          color: Color(0xFFfb7750), width: 1.2)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                    borderSide:
                        const BorderSide(color: Color(0xFFfb7750), width: 1.2),
                  ),
                  prefixIcon: const Icon(
                    Icons.location_on_outlined,
                    color: Color(0xFFfb7750),
                  ),
                  hintText: "Search for location",
                  contentPadding: const EdgeInsets.all(16.0),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 50,
                child: ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 15,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: pro.cate.length,
                  itemBuilder: (context, index) => ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.transparent),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22.0),
                        ),
                      ),
                    ),
                    onPressed: () async {
                     pro.data_map(pro.cate[index]['id']);
                     pro.data_mark(pro.cate[index]['id']);
                    },
                    icon: Icon(
                      IconDataSolid(int.parse(pro.cate[index]['icon_name'])),
                      color: HexColor.fromHex(pro.cate[index]['color']),
                    ),
                    label: Text(pro.cate[index]['name'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
                ),
              )
            ],
          ),
        ),
        _buildContainer(),

        Positioned(
          bottom: 22,
          left: 16,
          child: CircleAvatar(
            backgroundColor: Color(0xFFfb7750),
            child: IconButton(
              onPressed: () {
                var pos = LocationHelper.getCurrentLocation();
                pos.then((value) {

                });
              },
              icon: const Icon(FontAwesomeIcons.childReaching),
              alignment: Alignment.bottomLeft,
              color: Colors.white,
            ),
          ),
        ),
        // CarouselWithDotsPage(imgList: imgList),
      ]),
    );
  }
  Widget _buildContainer() {
    var p = Provider.of<func_provider>(context);
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20.0),
        height: 150.0,
        child: ListView.builder(
          itemBuilder: (context, index) =>
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () async {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) =>
                    //         HospitalDetails(
                    //           url: 'assets/images/hospital1/z.jpg',
                    //           id: '20',
                    //           data: const [
                    //             {
                    //               "name": "Nashwa Center",
                    //               "brand": "Protect your child with us",
                    //               "price": 2.99,
                    //               "image": "assets/images/hospital1/n1.jpg"
                    //             },
                    //             {
                    //               "name": "Nashwa Center",
                    //               "brand": "Your child is safe",
                    //               "price": 4.99,
                    //               "image": "assets/images/hospital1/n2.jpg"
                    //             },
                    //             {
                    //               "name": "Nashwa Center",
                    //               "brand": "The best baby care",
                    //               "price": 1.49,
                    //               "image": "assets/images/hospital1/n3.jpg"
                    //             },
                    //             {
                    //               "name": "Nashwa Center",
                    //               "brand": "24 hours service",
                    //               "price": 2.99,
                    //               "image": "assets/images/hospital1/n4.jpg"
                    //             },
                    //           ],
                    //           address:
                    //           'د. نشوة حسين العشرى - استشارى طب اطفال وحديثى الولادة والرضاعة الطبيعية',
                    //         )));
                  },
                  child: FittedBox(
                    child: Material(
                        color: Colors.white,
                        elevation: 14.0,
                        borderRadius: BorderRadius.circular(24.0),
                        shadowColor: const Color(0x802196F3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(
                              width: 180,
                              height: 200,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(24.0),
                                child: const Image(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      "https://lh5.googleusercontent.com/p/AF1QipMKRN-1zTYMUVPrH-CcKzfTo6Nai7wdL7D8PMkt=w340-h160-k-no"),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceEvenly,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      p.sliderData[index]['name'],
                                      style: const TextStyle(
                                          color: Color(0xff6200ee),
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text(
                                        '${ p.sliderData[index]['rate']}',
                                        style: const TextStyle(
                                          color: Colors.black54,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      const Icon(
                                        FontAwesomeIcons.solidStar,
                                        color: Colors.amber,
                                        size: 15.0,
                                      ),
                                      const Icon(
                                        FontAwesomeIcons.solidStar,
                                        color: Colors.amber,
                                        size: 15.0,
                                      ),
                                      const Icon(
                                        FontAwesomeIcons.solidStar,
                                        color: Colors.amber,
                                        size: 15.0,
                                      ),
                                      const Icon(
                                        FontAwesomeIcons.solidStar,
                                        color: Colors.amber,
                                        size: 15.0,
                                      ),
                                      const Icon(
                                        FontAwesomeIcons.solidStarHalf,
                                        color: Colors.amber,
                                        size: 15.0,
                                      ),
                                      const Text(
                                        "(946)",
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5.0),
                                  InkWell(
                                    onTap: () {
                                      MapUtils.map(double.parse(
                                          p.sliderData[index][lat]),
                                          double.parse(
                                              p.sliderData[index]['long']));
                                    },
                                    child: Card(
                                      child: Row(
                                        children: const [
                                          Icon(
                                            FontAwesomeIcons.locationArrow,
                                            size: 30,
                                            color: Colors.deepOrange,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 10.0),
                                            child: Text(
                                              '150 M',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 24.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                  const Text(
                                    "Closed \u00B7 Opens 17:00 Thu",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              ),
          itemCount: p.sliderData.length,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

}
