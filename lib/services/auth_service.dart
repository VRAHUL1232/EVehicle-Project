import 'package:ev_charger/screens/home_screen.dart';
import 'package:ev_charger/screens/search_screen.dart';
import 'package:ev_charger/widgets/error_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AuthService {
  createUser(data, context) async {
    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: data['email'],
        password: data['password'],
      );

    await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set(data);

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => SearchScreen(userCredential:userCredential,),
      ));
    } on FirebaseAuthException catch (e) {
      return showDialog(
        context: context,
        builder: (context) {
          return ErrorDialog(errorMessage: e.message!, errorTitle: "Sign up Failed");
        },
      );
    }
  }

  login(data, context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: data['email'], password: data['password']);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => const HomeScreen(),));

    } on FirebaseAuthException catch (e) {
      return showDialog(
        context: context,
        builder: (context) {
          return ErrorDialog(errorMessage: e.message!, errorTitle: "Login Failed");
        },
      );
    }
  }

}
