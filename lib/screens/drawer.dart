import 'package:ev_charger/screens/home_screen.dart';
import 'package:ev_charger/screens/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({super.key, required this.onSelectedScreen});

  final void Function(String identifier) onSelectedScreen;

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  String title = "";
  titleGetter() async {
    final data =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    setState(() {
      title = data['username'];
    });
  }

  @override
  void initState() {
    super.initState();
    titleGetter();
  }

  @override
  Widget build(context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: SizedBox(
              height: 220,
              width: double.infinity,
              child: DrawerHeader(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(3, 151, 151, 1)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              AssetImage("assets/images/user-profile.png")),
                      const SizedBox(
                        height: 14,
                      ),
                      SizedBox(
                        width: 220,
                        child: Center(
                          child: Text(
                            title.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          ListTile(
            leading: const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Icon(
                Icons.perm_identity,
                size: 25,
                color: Colors.black,
              ),
            ),
            title: const Text("My Account",
                style: TextStyle(color: Colors.black, fontSize: 20)),
            onTap: () {
              widget.onSelectedScreen('my-account');
            },
          ),
          const SizedBox(
            height: 5,
          ),
          ListTile(
            leading: const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Icon(
                Icons.pin_drop_outlined,
                size: 25,
                color: Colors.black,
              ),
            ),
            title: const Text("Preferred Location",
                style: TextStyle(color: Colors.black, fontSize: 20)),
            onTap: () {
              widget.onSelectedScreen('preferred-location');
            },
          ),
          const SizedBox(
            height: 5,
          ),
          ListTile(
            leading: const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Icon(
                Icons.assignment_turned_in,
                size: 25,
                color: Colors.black,
              ),
            ),
            title: const Text("My Bookings",
                style: TextStyle(color: Colors.black, fontSize: 20)),
            onTap: () {
              widget.onSelectedScreen('my-bookings');
            },
          ),
          const SizedBox(
            height: 5,
          ),
          ListTile(
            leading: const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Icon(
                Icons.help_outline_rounded,
                size: 25,
                color: Colors.black,
              ),
            ),
            title: const Text("Help and Support",
                style: TextStyle(color: Colors.black, fontSize: 20)),
            onTap: () {
              widget.onSelectedScreen('help/support');
            },
          ),
          const SizedBox(
            height: 50,
          ),
          ListTile(
            leading: const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Icon(
                Icons.exit_to_app,
                size: 25,
                color: Colors.black,
              ),
            ),
            title: const Text(
              "Sign out",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            onTap: () async {
              try {
                await FirebaseAuth.instance.signOut();
                // Navigate to the login or home screen after successful sign-out
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const LoginView(),
                )); // Replace '/login' with your desired route
              } catch (e) {}
            },
          ),
        ],
      ),
    );
  }
}
