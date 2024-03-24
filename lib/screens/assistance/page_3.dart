import 'package:ev_charger/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AssistPage3 extends StatelessWidget {
  const AssistPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          children: [
            Image.asset(
              "assets/images/page1.png",
              width: double.infinity,
              height: 520,
            ),
             Positioned(
                top: 380,
                child: SizedBox(
                  width:  MediaQuery.of(context).size.width,
                  child:const Center(
                    child: Text(
                      "CHARGED",
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                )),
             Positioned(
                top: 440,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child:const Center(
                    child: Text(
                        "The vehicle is charged, ready to ride.",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                    ),
                  ),
                )),
                Positioned(bottom: 0, right: 30, child: TextButton(onPressed: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => HomeScreen(),));
                }, child: Text("Skip", style: TextStyle(color: Color.fromRGBO(3, 151, 151, 1), fontSize: 20),)))
          ],
        ),
      ),
    );
  }
}
