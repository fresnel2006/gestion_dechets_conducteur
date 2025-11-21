import 'package:flutter/material.dart';
import 'package:hackaton_conducteur/Pages/Copilote1.dart';
import 'package:hackaton_conducteur/Pages/Copilote2.dart';
import 'package:hackaton_conducteur/Pages/Drawer.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Inscription2Page extends StatefulWidget {
  const Inscription2Page({super.key});


  @override
  State<Inscription2Page> createState() => _Inscription2PageState();
}
var validation1;
var validation2;
var valeur_final;
class _Inscription2PageState extends State<Inscription2Page> {
  void verfications(){
    if (valeur_final==true){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>DrawerPage()), (route)=>false);
      sauvegarde_de_redirection();
    }
  }
  Future <void> sauvegarde_de_redirection() async {
    var perfs=await SharedPreferences.getInstance();
    perfs.setBool("rediction_page", true);
  }
  Future <void> charger_valeur() async{
    var perfs=await SharedPreferences.getInstance();
    setState(() {
      validation1= perfs.getBool("validation1")??false;
      validation2= perfs.getBool("validation2")??false;
      if(validation1==true && validation2==true){
        setState(() {
          valeur_final=true;
        });

      }else{
        setState(() {
          valeur_final=false;
        });
      }
      print(validation1);
      print(validation2);
    });
  }
  @override
  void initState(){
    super.initState();
    charger_valeur();
  }
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(

        child:Stack(
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.05,left: MediaQuery.of(context).size.width *0.03),
                  child: Row(children: [
                    IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon:Icon(Icons.arrow_back,size: MediaQuery.of(context).size.width *0.08,color: Colors.black,),
                    ),SizedBox(width: MediaQuery.of(context).size.width *0.07,),
                    Text("CREATION DES COMPTES",style: TextStyle(fontFamily: "Poppins",fontSize: MediaQuery.of(context).size.width *0.045),)
                  ],),),
                Container(child: Lottie.asset("assets/animations/Becket_Trash can.json",height: MediaQuery.of(context).size.height *0.25),),
                SizedBox(height: MediaQuery.of(context).size.height *0.02,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Copilote1Page()));
                  },
                  child:Container(
                  alignment: AlignmentGeometry.center,
                  width: MediaQuery.of(context).size.width *0.7,
                  height: MediaQuery.of(context).size.height *0.055,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.1)),
                    border: Border.all(color: Colors.green,width: MediaQuery.of(context).size.width *0.006)
                  ),
                  child: Text("COPILOTE 1",style: TextStyle(fontFamily: "Poppins",fontSize: MediaQuery.of(context).size.width *0.045),),
                  ),),
                SizedBox(height: MediaQuery.of(context).size.height *0.03,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Copilote2Page()));
                  },
                  child: Container(
                  alignment: AlignmentGeometry.center,
                  width: MediaQuery.of(context).size.width *0.7,
                  height: MediaQuery.of(context).size.height *0.055,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.1)),
                      border: Border.all(color: Colors.green,width: MediaQuery.of(context).size.width *0.006)
                  ),
                  child: Text("COPILOTE 2",style: TextStyle(fontFamily: "Poppins",fontSize: MediaQuery.of(context).size.width *0.045)),
                ),),
                SizedBox(height: MediaQuery.of(context).size.height *0.05,),
                GestureDetector(
                  onTap: (){
                 },
                  child: GestureDetector(
                    onTap: (){
verfications();

                    },
                    child: Container(
                  alignment: AlignmentGeometry.center,
                  width: MediaQuery.of(context).size.width *0.9,
                  height: MediaQuery.of(context).size.height *0.055,
                  decoration: BoxDecoration(
                    color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.1)),
                      border: Border.all(color: Colors.black,)
                  ),
                   child: Text("PROCHAINE ETAPES",style: TextStyle(fontFamily: "Poppins",fontSize: MediaQuery.of(context).size.width *0.045))),
                ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height *0.020,),
                valeur_final!=false?Container(
                    child: Column(children: [
                      Container(child: Lottie.asset("assets/animations/Success.json",height: MediaQuery.of(context).size.height *0.23),),
                      Text("MERCI ! ",style: TextStyle(fontFamily: "Poppins"),)
                    ],)):Container(
                    child: Column(children: [
                      SizedBox(height: MediaQuery.of(context).size.height *0.06,),
                      Container(child: Lottie.asset("assets/animations/Warning animation.json"),),
                      Text("VOUS DEVEZ FINIR LES \nDIFFERENTES INSCRIPTIONS",textAlign: TextAlign.center,style: TextStyle(fontFamily: "Poppins"),)
                    ],))
            ],)
          
        ],) ,
      ),
    );
  }
}
