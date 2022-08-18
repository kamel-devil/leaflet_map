import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../tools/to_map.dart';
import 'map.dart';

class InfoMark extends StatelessWidget {
  InfoMark(
      {Key? key,
      required this.lat,
      required this.long,
      required this.name,
      required this.Address,required this.rate})
      : super(key: key);
  double lat;
  double long;
  String name;
  String Address;
  int rate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //
        // ),
        body: Container(
      padding: const EdgeInsets.only(top: 32.0, left: 16, right: 16),
      color: const Color(0xFF414171),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: const Color(0xFFfb7750),
                radius: 25,
                child: Center(
                  child: IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyHomePage()));
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      )),
                ),
              ),
              IconButton(
                  onPressed: () {
                    launchUrl(Uri.parse('tel:/01737e6rye7ru'));
                  },
                  icon: const Icon(
                    Icons.phone,
                    size: 40,
                    color: Color(0xFFfb7750),
                  ))
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24.0),
              child: const Image(
                width: 150,
                height: 180,
                fit: BoxFit.fill,
                image: NetworkImage(
                    "https://media-exp1.licdn.com/dms/image/C560BAQEbf8JIlos_OQ/company-logo_200_200/0/1601725366000?e=2147483647&v=beta&t=eDMS-Z5XFwbiLv4AisUTy-XBd-NXc1Fgh2eGjM_3omQ"),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(children: [
              Text(
                name,
                style:
                    const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                softWrap: true,
                overflow: TextOverflow.clip,
              ),
              const Text(
                "Address",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              Text(
                Address,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Card(
                        color: const Color(0xFF53538A),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: const Padding(
                          padding: EdgeInsets.only(
                              top: 10, bottom: 10, left: 10, right: 12),
                          child: Icon(
                            FontAwesomeIcons.solidStar,
                            color: Colors.amber,
                            size: 15.0,
                          ),
                        ),
                      ),
                      Card(
                        color: const Color(0xFF53538A),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: const Padding(
                          padding: EdgeInsets.only(
                              top: 10, bottom: 10, left: 10, right: 12),
                          child: Icon(
                            FontAwesomeIcons.peopleGroup,
                            color: Colors.white,
                            size: 15.0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                    ]),
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children:  [
                          const Text(
                            'Rating',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 18.0,
                            ),
                          ),
                          Text(
                            '$rate out of 5',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: const [
                          Text(
                            'people',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 18.0,
                            ),
                          ),
                          Text(
                            '1000+',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ])
              ])
            ]),
          ]),
          const SizedBox(height: 124),
          Container(
            decoration: BoxDecoration(
                color: const Color(0xFF53538A),
                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  'Biography',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                const Text(
                  'Biographyaskfvnakla \n'
                  'agfvavavavsdvwasedgvs\n'
                  'savavasdv  .readmore',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                  textAlign: TextAlign.left,
                ),
                const Text(
                  'Location',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                InkWell(
                  onTap: () {
                    MapUtils.map(lat, long);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24.0),
                    child: const Image(
                      width: 280,
                      height: 150,
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          "https://images1.arabicprogrammer.com/224/ea/eaa419d40d1627175a67d81d5dd60d18.png"),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),);
  }
}
