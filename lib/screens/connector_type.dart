import 'package:ev_charger/screens/assistance/page_1.dart';
import 'package:ev_charger/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ConnectorType extends StatefulWidget {
  final UserCredential userCredential;
  const ConnectorType({super.key, required this.userCredential});
  @override
  State<ConnectorType> createState() {
    return _ConnectorTypeState();
  }
}

class _ConnectorTypeState extends State<ConnectorType> {
  @override
  Widget build(BuildContext context) {
    const _displayType = [
      "AC Type 1",
      "AC Type 2",
      "DC001",
      "CCS 1",
      "CCS 2",
      "Bharat AC001",
      "Bharat DC001",
      "AC Plug Point",
      "CHAdeMo",
      "Tesla Charger",
      "GB/T"
    ];

    void onPressed(int index, String name) async {
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.userCredential.user!.uid)
            .update({
          'cable-type': name,
        });
      } catch (err) {}
      Future.delayed(
        const Duration(milliseconds: 200),
        () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const AssistPage1(),
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
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Select your Connector",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _displayType.length,
                itemBuilder: (context, index) => Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10, right: 30, left: 30),
                  child: ListTile(
                    onTap: () {
                      onPressed(index, _displayType[index]);
                    },
                    title: Text(
                      _displayType[index],
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
