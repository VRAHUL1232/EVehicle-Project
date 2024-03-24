import 'package:flutter/material.dart';

class UserSuccess extends StatelessWidget {
  const UserSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,),
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, gradient: LinearGradient(colors: [
                            Color.fromRGBO(20, 161, 161, 1),
                            Color.fromRGBO(0, 66, 66, 1)
                          ])),
                          child: Center(child: Icon(Icons.check_circle_outline_sharp,size: 70,)),
          ),
          SizedBox(height: 10,),
          Text("Payment Successful", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text("Your payment to the charging station is completed successfully", style: TextStyle(color: Colors.white, fontSize: 15,),),
          )
        ],
      ),
    );
  }
}
