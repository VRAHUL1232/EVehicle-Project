import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ev_charger/data/dataset.dart';
import 'package:ev_charger/screens/drawer_screens/my_bookings.dart';
import 'package:ev_charger/screens/drawer_screens/help_support.dart';
import 'package:ev_charger/screens/drawer_screens/my_account.dart';
import 'package:ev_charger/screens/drawer_screens/preferred_location.dart';
import 'package:ev_charger/screens/location_search.dart';
import 'package:ev_charger/screens/place_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'drawer.dart';
import 'sign_up.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final userId = FirebaseAuth.instance.currentUser!.uid;

class _HomeScreenState extends State<HomeScreen> {
  String onSelectedScreen = "none";
  var isLogoutLoading = false;
  drawerNavigator(value) {
    if (value == "my-account") {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const MyAccount(),
      ));
    }
    if (value == "preferred-location") {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const PreferredLocation(),
      ));
    }
    if (value == "my-bookings") {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const MyBookings(),
      ));
    }
    if (value == "help/support") {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const HelpandSupport(),
      ));
    }
    if (value == "sign-out") {
      logout();
    }
  }

  @override
  void initState() {
    super.initState();
    drawerNavigator(onSelectedScreen);
  }

  logout() async {
    setState(() {
      isLogoutLoading = true;
    });
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => SignUpView(),
    ));
    setState(() {
      isLogoutLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    const yourLat = 12.9899133;
    const yourLong = 80.236447;
    String qrcodedata;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 60,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const LocationSearchPage(),
                  ));
                },
                icon: const Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 26,
                  ),
                ))
          ],
          backgroundColor: const Color.fromRGBO(3, 151, 151, 1),
          title: const Text(
            "Charging Stations",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        drawer: MainDrawer(onSelectedScreen: (value) {
          setState(() {
            onSelectedScreen = value;
          });
        }),
        body: Stack(
          children: [
            FlutterMap(
              options: const MapOptions(
                  initialZoom: 12, initialCenter: LatLng(yourLat, yourLong)),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                ),
                MarkerLayer(markers: [
                  const Marker(
                      point: LatLng(yourLat, yourLong),
                      width: 80,
                      height: 80,
                      child: Icon(
                        Icons.my_location,
                        size: 30,
                        color: Colors.blue,
                      )),
                  for (final place in dummyplaces)
                    Marker(
                        width: 80.0,
                        height: 80.0,
                        point: LatLng(place.latCord, place.longCord),
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  PlaceDetails(location: place),
                            ));
                          },
                          icon: Icon(
                            Icons.location_on,
                            color: (place.acsource == true &&
                                    place.dcsource == true)
                                ? Colors.orange
                                : (place.acsource == true)
                                    ? Colors.red
                                    : Colors.green,
                            size: 45,
                          ),
                        )),
                ])
              ],
            ),
            Positioned(
                bottom: 30,
                right: 30,
                child: FloatingActionButton(
                    backgroundColor: Colors.white,
                    onPressed: () {},
                    child: const Icon(
                      Icons.my_location,
                      color: Colors.black,
                    ))),
            Positioned(
                top: 20,
                right: 20,
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.red),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "AC Type",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.green),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "DC Type",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.orange),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "AC & DC",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                )),
            Positioned(
              bottom: 30,
              left: 50,
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(48),
                    gradient: const LinearGradient(colors: [
                      Color.fromRGBO(20, 161, 161, 1),
                      Color.fromRGBO(0, 66, 66, 1)
                    ])),
                child: ElevatedButton.icon(
                  onPressed: () async {
                    ScanResult codeScanner = await BarcodeScanner.scan();
                    setState(
                      () {
                        qrcodedata = codeScanner.rawContent;
                      },
                    );
                  },
                  icon: Icon(
                    Icons.qr_code,
                    color: Colors.white,
                    size: 20,
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent),
                  label: const Text(
                    "Scan QR",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
