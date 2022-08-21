import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_app/provider/provider.dart';
import 'package:map_app/tools/to_map.dart';
import 'package:provider/provider.dart';

import '../tools/color_data.dart';
import 'info_mark.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PopupController _popupController = PopupController();

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<Funcprovider>(context);
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
            onPositionChanged: (position, bo) {
              print(position.center);
            } ,
            center: LatLng(pro.lat!, pro.long!),
            zoom: 18,
            plugins: [
              MarkerClusterPlugin(),
            ],
            // onTap: (_, i) => _popupController.hideAllPopups(),
          ),
          layers: [
            TileLayerOptions(
              maxZoom: 22,
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
            ),
             MarkerLayerOptions(markers: pro.mark),
            // MarkerClusterLayerOptions(
            //   maxClusterRadius: 120,
            //   disableClusteringAtZoom: 6,
            //   size: const Size(40, 40),
            //   anchor: AnchorPos.align(AnchorAlign.center),
            //   fitBoundsOptions:
            //       const FitBoundsOptions(padding: EdgeInsets.all(50)),
            //   markers: pro.mark,
            //   popupOptions: PopupOptions(
            //     popupSnap: PopupSnap.markerTop,
            //     popupController: _popupController,
            //     popupBuilder: (_, maker) => Container(
            //       width: 200,
            //       height: 100,
            //       color: Colors.white,
            //       child: GestureDetector(
            //         onTap: () => debugPrint('Popup tap!'),
            //         child: Text('Container popup for marker at '),
            //       ),
            //     ),
            //   ),
            //   builder: (context, markers) {
            //     return FloatingActionButton(
            //         onPressed: null, child: Text(markers.length.toString()));
            //   },
            // )
          ],
        ),




        Container(
          height: 250,
          padding: const EdgeInsets.symmetric(vertical: 64.0, horizontal: 16.0),
          // height: 120,
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    color: const Color(0xFFfb7750),
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      pro.dataMap('0');
                      pro.dataMark('0',pro.lat!,pro.long!);
                    },
                  ),
                  Expanded(
                    child: TextFormField(
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
                          borderSide: const BorderSide(
                              color: Color(0xFFfb7750), width: 1.2),
                        ),
                        prefixIcon: const Icon(
                          Icons.location_on_outlined,
                          color: Color(0xFFfb7750),
                        ),
                        hintText: "Search for location",
                        contentPadding: const EdgeInsets.all(16.0),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
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
                      pro.dataMap(pro.cate[index]['id']);
                      // pro.dataMark(pro.cate[index]['id'],);
                    },
                    icon: Icon(
                      IconDataSolid(int.parse(pro.cate[index]['icon_name'])),
                      color: HexColor.fromHex(pro.cate[index]['color']),
                    ),
                    label: Text(
                      pro.cate[index]['name'],
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
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
            backgroundColor: const Color(0xFFfb7750),
            child: IconButton(
              onPressed: () {
                var pos = pro.getCurrentLocation();
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
    var p = Provider.of<Funcprovider>(context);
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20.0),
        height: 150.0,
        child: ListView.builder(
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () async {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InfoMark(
                              lat: double.parse(p.sliderData[index]['lat']),
                              long: double.parse(p.sliderData[index]['long']),
                              name: p.sliderData[index]['name'],
                              Address: p.sliderData[index]['address'],
                              rate: p.sliderData[index]['rate'],
                            )));
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
                                  "https://media-exp1.licdn.com/dms/image/C560BAQEbf8JIlos_OQ/company-logo_200_200/0/1601725366000?e=2147483647&v=beta&t=eDMS-Z5XFwbiLv4AisUTy-XBd-NXc1Fgh2eGjM_3omQ"),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                    '${p.sliderData[index]['rate']}',
                                    style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 18.0,
                                    ),

                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                          height: 30,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            itemCount: p.sliderData[index]
                                            ['rate'],
                                            itemBuilder: (context, index) =>
                                            const Icon(
                                              FontAwesomeIcons.solidStar,
                                              color: Colors.amber,
                                              size: 25.0,
                                            ),
                                          )),
                                      SizedBox(
                                          height: 30,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            itemCount:  -(p.sliderData[index]
                                            ['rate']) +5
                                                ,
                                            itemBuilder: (context, index) =>
                                            const Icon(
                                              FontAwesomeIcons.star,
                                              color: Colors.amber,
                                              size: 25.0,
                                            ),
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5.0),
                              InkWell(
                                onTap: () {
                                  MapUtils.map(
                                      double.parse(p.sliderData[index]['lat']),
                                      double.parse(
                                          p.sliderData[index]['long']));
                                },
                                child: Card(
                                  child: Row(
                                    children: const [
                                      Icon(
                                        FontAwesomeIcons.locationDot,
                                        size: 23,
                                        color: Color(0xFFfb7750),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child: Text(
                                          '??? M',
                                          style: TextStyle(
                                              color: Colors.black,
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
                                " Opening 24 H",
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
