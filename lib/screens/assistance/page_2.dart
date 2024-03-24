import 'package:ev_charger/screens/assistance/page_3.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AssistPage2 extends StatelessWidget {
  const AssistPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          children: [
            Image.asset(
              "assets/images/page2.png",
              width: double.infinity,
              height: 520,
            ),
             Positioned(
                top: 350,
                child: SizedBox(
                  width:  MediaQuery.of(context).size.width,
                  child:const Center(
                    child: Text(
                      "CHOOSE PLUG",
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                )),
             Positioned(
                top: 410,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child:const Center(
                    child: Text(
                        "Select your vehicle plug type.",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                    ),
                  ),
                )),
                Positioned(bottom: 0, right: 30, child: TextButton(onPressed: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => AssistPage3(),));
                }, child: Text("Skip", style: TextStyle(color: Color.fromRGBO(3, 151, 151, 1), fontSize: 20),)))
          ],
        ),
      ),
    );
  }
}
