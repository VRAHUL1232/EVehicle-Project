import 'package:ev_charger/screens/home_screen.dart';
import 'package:ev_charger/screens/mainscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const MainScreen();
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Colors.black,
            body: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }
        return const HomeScreen();
      },
    );
  }
}
