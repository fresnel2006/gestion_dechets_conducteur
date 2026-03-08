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
      body: SingleChildScrollView(
        child:Column(
          spacing: MediaQuery.of(context).size.height *0.018,
          children: [
            Row(

              children: [
                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.05,left: MediaQuery.of(context).size.width *0.03),
                  child:  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(Icons.arrow_back,color: Colors.black,size: MediaQuery.of(context).size.width *0.08,)),
                )
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height *0.01,),

            Container(

                alignment: AlignmentDirectional.topStart,
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.1),

              child: Text("Equipe {0}",style: TextStyle(fontFamily: "Poppins",fontSize: MediaQuery.of(context).size.width *0.04),),
            ),
            Container(
              alignment: AlignmentDirectional.topStart,
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.1),

              child: Text("Matricule : ",style: TextStyle(fontFamily: "Poppins",fontSize: MediaQuery.of(context).size.width *0.04)),
            ),
            Container(
              alignment: AlignmentDirectional.topStart,
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.1),

              child: Text("Chef : ",style: TextStyle(fontFamily: "Poppins",fontSize: MediaQuery.of(context).size.width *0.04)),
            ),
            Container(
              alignment: AlignmentDirectional.topStart,
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.1),
              child: Text("Copilote 1 : ",style: TextStyle(fontFamily: "Poppins",fontSize: MediaQuery.of(context).size.width *0.04)),
            ),
            Container(
              alignment: AlignmentDirectional.topStart,
    margin: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.1),
              child: Text("Copilote 2 : ",style: TextStyle(fontFamily: "Poppins",fontSize: MediaQuery.of(context).size.width *0.04)),
            ),
            Container(
              alignment: AlignmentDirectional.topStart,
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.1),
              child: Text("Numero : ",style: TextStyle(fontFamily: "Poppins",fontSize: MediaQuery.of(context).size.width *0.04)),
            ),
            SizedBox(height: MediaQuery.of(context).size.height *0.06,),

            Container(decoration:BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *1)),border: Border.all(color: Colors.green)),child: CircleAvatar(backgroundColor: Colors.lightGreen[50] ,radius: 45,child: Lottie.asset("assets/animations/Truck Green Blue.json"),),
            ),
            SizedBox(height: MediaQuery.of(context).size.height *0.025,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child:
                  Container(
                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.03),height: MediaQuery.of(context).size.height *0.065,
                      decoration: BoxDecoration(border: Border.all(color: Colors.green),color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.1))),
                      width: MediaQuery.of(context).size.width *0.4,
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add),
                          SizedBox(width: MediaQuery.of(context).size.width *0.02,),
                          Text("Voir plus",style: TextStyle(color: Colors.green,fontFamily: "Poppins2"))
                        ],
                      )),),
                GestureDetector(
                    child:
                    Container(
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.03),height: MediaQuery.of(context).size.height *0.065,
                        decoration: BoxDecoration(border: Border.all(color:  Colors.green),color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.1))),
                        width: MediaQuery.of(context).size.width *0.4,
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.headset_mic_outlined),
                            SizedBox(width: MediaQuery.of(context).size.width *0.02,),
                            Text("Assistance",style: TextStyle(color: Colors.green,fontFamily: "Poppins2"))
                          ],
                        ))),
              ],
            )



          ],) ,
      )
    );
  }
}
