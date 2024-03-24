import 'package:ev_charger/data/dataset.dart';
import 'package:ev_charger/model/car.dart';
import 'package:ev_charger/screens/connector_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  final UserCredential userCredential;
  const SearchScreen({super.key, required this.userCredential});
  @override
  State<SearchScreen> createState() {
    return _SearchScreenState();
  }
}

class _SearchScreenState extends State<SearchScreen> {
  List<Car> _displayItems = List.from(dummyCars);

  void updateList(String value) {
    setState(() {
      _displayItems = dummyCars
          .where((car) => car.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    void onPressed(int index, Car car) async {
     try{
       await FirebaseFirestore.instance.collection('users').doc(widget.userCredential.user!.uid).update({
        'vehicle': car.name,
      });
     } catch(err){
     }
      Future.delayed(
        const Duration(milliseconds: 200),
        () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => ConnectorType(userCredential: widget.userCredential,),
          ));
        },
      );
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20,),
            const Text(
              "Add Vehicle",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "Your vehicle is determine compatible charging station.",
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
            Image.asset(
              "assets/images/search_car.png",
              width: 320,
              height: 210,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24,),
              child: TextField(
                onChanged: (value) {
                  updateList(value);
                },
                style:const TextStyle(
                    color: Colors.black,
                    fontSize: 18),
                decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 23),
                    hintText: "Search Vehicle",
                    hintStyle: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: IconButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                        },
                        icon:const Icon(Icons.search),
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
                            style:const TextStyle(
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
