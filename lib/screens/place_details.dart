import 'package:ev_charger/model/location.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PlaceDetails extends StatefulWidget {
  final Location location;
  const PlaceDetails({super.key, required this.location});

  @override
  State<PlaceDetails> createState() => _PlaceDetailsState();
}

class _PlaceDetailsState extends State<PlaceDetails> {

   _launchURL() async {
    final url = Uri.parse("https://www.google.com/maps"); 
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(3, 151, 151, 1),
        toolbarHeight: 60,
        title: const Text(
          "Place Details",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              widget.location.name,
              style: const TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.location.address,
              style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      "Power Rating ${widget.location.powerRating} kWh",
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: 14,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "8.00 am - 12.00 pm",
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                Spacer(),
                Column(children: [
                  Text(
                  "Review",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5,),
                Row(children: [
                  Text(widget.location.reviewRating.toString(), style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                  SizedBox(width: 5,),
                  Icon(Icons.star, color: Colors.yellow, size: 22,)
                ],)
                ],)
              ],
            ),
            SizedBox(height: 15,),
            Text(
              "Available Charging Ports",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 32,),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(children: [Image.asset("assets/images/ac-plug-pnt.png",width: 50,height: 50,color: (widget.location.acplugpnt) ? Colors.green : Colors.grey,),
                    Text("AC Plug",style: TextStyle(color: Colors.black),)],),
                    Column(children: [Image.asset("assets/images/ac-type-1.png",width: 50,height: 50,color: (widget.location.acType1) ? Colors.green : Colors.grey),
                    Text("AC Type 1",style: TextStyle(color: Colors.black))],),
                    Column(children: [Image.asset("assets/images/ac-type-2.png",width: 50,height: 50,color: (widget.location.acType2) ? Colors.green : Colors.grey),
                    Text("AC Type 2",style: TextStyle(color: Colors.black))],),
                    Column(children: [Image.asset("assets/images/bharat-ac001.png",width: 50,height: 50,color: (widget.location.bharatAc001) ? Colors.green : Colors.grey),
                    Text("Bharat AC",style: TextStyle(color: Colors.black))],)
                  ],
                ),
                SizedBox(
                  height: 32,
                ),
                Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(children: [Image.asset("assets/images/bharat-dc001.jpg",width: 50,height: 50,color: (widget.location.bharatDc001) ? Colors.green : Colors.grey),
                    Text("Bharat DC",style: TextStyle(color: Colors.black))],),
                    Column(children: [Image.asset("assets/images/ccs-1.png",width: 50,height: 50,color: (widget.location.ccs1) ? Colors.green : Colors.grey),
                    Text("CCS 1",style: TextStyle(color: Colors.black))],),
                    Column(children: [Image.asset("assets/images/ccs-2.png",width: 50,height: 50,color: (widget.location.ccs2) ? Colors.green : Colors.grey),
                    Text("CCS 2",style: TextStyle(color: Colors.black))],),
                    Column(children: [Image.asset("assets/images/CHAdeMO.png",width: 50,height: 50,color: (widget.location.chademo) ? Colors.green : Colors.grey),
                    Text("CHAdeMO",style: TextStyle(color: Colors.black))],)
                  ],
                ),
                SizedBox(
                  height: 32,
                ),
                Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(children: [Image.asset("assets/images/gb-t.png",width: 50,height: 50,color: (widget.location.gbt) ? Colors.green : Colors.grey),
                    Text("GBT",style: TextStyle(color: Colors.black))],),
                    SizedBox(width: 25,),
                    Column(children: [Image.asset("assets/images/tesla-charger.png",width: 50,height: 50,color: (widget.location.teslaCharger) ? Colors.green : Colors.grey),
                    Text("Tesla",style: TextStyle(color: Colors.black))],)
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                String url = "https://www.google.com/maps/search/?api=1&query=${widget.location.latCord}%2C${widget.location.longCord}";
                launchUrlString(url);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(3, 151, 151, 1),
                  shadowColor: Colors.transparent),
              child: const Text(
                "Navigate",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
