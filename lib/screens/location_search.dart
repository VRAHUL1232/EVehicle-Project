import 'package:ev_charger/data/dataset.dart';
import 'package:ev_charger/model/location.dart';
import 'package:ev_charger/screens/place_details.dart';
import 'package:flutter/material.dart';

class LocationSearchPage extends StatefulWidget {
  const LocationSearchPage({super.key});
  @override
  State<LocationSearchPage> createState() {
    return _LocationSearchPageState();
  }
}

class _LocationSearchPageState extends State<LocationSearchPage> {
  List<Location> _displayItems = List.from(dummyplaces);

  void updateList(String value) {
    setState(() {
      _displayItems = dummyplaces
          .where((location) => location.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    void onPressed(int index, Location location) async {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => PlaceDetails(location: location),));
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Search", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
          backgroundColor: const Color.fromRGBO(3, 151, 151, 1),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 10),
              child: TextField(
                onChanged: (value) {
                  updateList(value);
                },
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18),
                decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 23),
                    hintText: "Search location",
                    hintStyle:const TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: IconButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                        },
                        icon: const Icon(Icons.search),
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40))),
              ),
            ),
            const SizedBox(height: 15,),
            Expanded(
                    child: ListView.builder(
                      itemCount: _displayItems.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10, right: 30, left: 30),
                        child: ListTile(          
                          onTap: () {
                            onPressed(index, _displayItems[index]);
                          },
                          title: Text(
                            _displayItems[index].name,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                  )
          ],
        ));
  }
}
