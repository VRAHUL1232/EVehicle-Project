
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  String username = "";
  String email = "";
  String carModel = "";
  String cableType = "";
  final userId = FirebaseAuth.instance.currentUser!.uid;
  titleGetter() async {
    final data = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    setState(() {
      username = data['username'];
      email = data['email'];
      carModel = data['vehicle'];
      cableType = data['cable-type'];
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
            child: Text(
          "My Account",
          style: TextStyle(color: Colors.white),
        )),
        backgroundColor: Color.fromRGBO(3, 151, 151, 1),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage("assets/images/user-profile.png")),
              SizedBox(height: 15,),
              Text(username,style: TextStyle(color: Colors.black, fontSize: 15,),),
              SizedBox(height: 15,),
              Text(email,style: TextStyle(color: Colors.black, fontSize: 15,),),
              SizedBox(height: 15,),
              Text(carModel,style: TextStyle(color: Colors.black, fontSize: 15,)),
              SizedBox(height: 15,),
              Text(cableType,style: TextStyle(color: Colors.black, fontSize: 15,))
        ],
      ),
    );
  }
}
