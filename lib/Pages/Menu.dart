import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lottie/lottie.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: MediaQuery.of(context).size.height *0.018,
        children: [
          Container(decoration:BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *1)),border: Border.all(color: Colors.green)),child: CircleAvatar(backgroundColor: Colors.lightGreen[50] ,radius: 45,child: Lottie.asset("assets/animations/Truck Green Blue.json"),),
          ),SizedBox(height: MediaQuery.of(context).size.height *0.025,),
          Container(
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.03),height: MediaQuery.of(context).size.height *0.065,
              decoration: BoxDecoration(border: Border.all(color: Colors.green),color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.1))),
              width: MediaQuery.of(context).size.width *1,
              child:Row(

                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.account_circle_sharp,color: Colors.green,),
                  TextButton(onPressed: (){

                  }, child: Text("LES COMPTES",style: TextStyle(color: Colors.black,fontFamily: "Poppins2")))
                ],
              )),




          Container(
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.03),height: MediaQuery.of(context).size.height *0.065,
              decoration: BoxDecoration(border: Border.all(color: Colors.green),color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.1))),
              width: MediaQuery.of(context).size.width *1,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add),
                  TextButton(onPressed: (){}, child: Text("VOIR PLUS",style: TextStyle(color: Colors.green,fontFamily: "Poppins2")))
                ],
              )),
          Container(
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.03),height: MediaQuery.of(context).size.height *0.065,
              decoration: BoxDecoration(border: Border.all(color:  Colors.green),color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.1))),
              width: MediaQuery.of(context).size.width *1,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.headset_mic_outlined),
                  TextButton(onPressed: (){}, child: Text("ASSISTANCE",style: TextStyle(color: Colors.green,fontFamily: "Poppins2")))
                ],
              )),




        ],),
    );
  }
}
