import 'package:ev_charger/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Welcome to",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w400,
                    color: Colors.white)),
            const SizedBox(
              height: 2,
            ),
            const Text(
              "ChargeWay",
              style: TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(0, 168, 168, 1)),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "Revitalise your Journey",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
            const SizedBox(
              width: 320,
              height: 270,
              child: Image(
                image: AssetImage("assets/images/mainscreen.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            SizedBox(
                width: 290,
                height: 56,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(0, 168, 168, 1)),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => SignUpView(),
                    ));
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "GET STARTED",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
