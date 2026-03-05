import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:hackaton_conducteur/Pages/Page.dart';

import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';


class EnsemblerapportsPage extends StatefulWidget {
  EnsemblerapportsPage({super.key, required this.latitude, required this.longitude});
var latitude;
var longitude;

  @override
  State<EnsemblerapportsPage> createState() => _EnsemblerapportsPageState();
}

class _EnsemblerapportsPageState extends State<EnsemblerapportsPage> {
  var identifiant;
  var data;
  final description=TextEditingController();
  var photo;

  final mot_de_passe=TextEditingController();

  void message_champ_vide(){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(seconds: 1),backgroundColor: Colors.transparent,content: GestureDetector(
        child: Container(
          height: MediaQuery.of(context).size.height *0.1,
          width: MediaQuery.of(context).size.width *1,
          decoration: BoxDecoration(color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.06))
          ),

          child: ListTile(
            title: Text("CHAMP VIDE",style: TextStyle(color: Colors.white,fontFamily: "Poppins"),),
            subtitle: Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.01),
              child: Text("VOUS DEVEZ ENTRER DES DONNEES",style: TextStyle(color: Colors.white70,fontFamily: "Poppins"),),),
            leading: Icon(Icons.dangerous,size: MediaQuery.of(context).size.width *0.15,color: Colors.white,),
          ),
        )
    )));
  }

  void message_de_validation(){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(seconds: 1),backgroundColor: Colors.transparent,content: GestureDetector(
        onTap: (){


        },
        child: Container(
      height: MediaQuery.of(context).size.height *0.1,
      width: MediaQuery.of(context).size.width *1,
      decoration: BoxDecoration(color: Colors.green,
          borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.06))
      ),
      child: ListTile(title: Text("ALLER A LA BASE",style: TextStyle(color: Colors.white,fontFamily: "Poppins"),),
        subtitle: Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.01),
          child: Text("MERCI !",style: TextStyle(color: Colors.white70,fontFamily: "Poppins"),),),
        leading: Icon(Icons.check_circle_outline,size: MediaQuery.of(context).size.width *0.15,color: Colors.white,),
      ),
    )
    )));
  }
  Future <void> sauvegarder_rapports()async{
    var perfs=await SharedPreferences.getInstance();
    await perfs.setStringList("rapport_description", rapport_description);
    await perfs.setStringList("longitude_tableau", longitude_tableau);
    await perfs.setStringList("latitude_tableau", latitude_tableau);
    await perfs.setStringList("date_tableau", date_tableau);
  }

List <String> rapport_description=[];
List <String> longitude_tableau=[];
List <String> latitude_tableau=[];
List <String> date_tableau=[];
var photo_tableau=[];
var photo_rapport;


Future <void> prendre_photo() async {
  photo = await ImagePicker().pickImage(source: ImageSource.camera);
  setState(() {
    photo_rapport = Image.file(File(photo!.path));
  });
}

  void ajouter_rapport()  {
    if(description.text.isNotEmpty){
      setState(() {
        description.clear();
      });
    }
    showModalBottomSheet(backgroundColor: Colors.transparent,context: context, builder: (context)=>SingleChildScrollView(
        child: Container(
      height: MediaQuery.of(context).size.height *1,
      width: MediaQuery.of(context).size.width *1,
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.green,width: 20)),
          borderRadius: BorderRadius.only(topRight: Radius.circular(MediaQuery.of(context).size.width *1),topLeft: Radius.circular(MediaQuery.of(context).size.width *1)),color: Colors.white),
      child: Column(
        children: [
        SizedBox(height: MediaQuery.of(context).size.height *0.07,),
        Container(child: Text("AJOUTER UN RAPPORT",style: TextStyle(fontFamily: "Poppins",fontSize: MediaQuery.of(context).size.width *0.06),),),
        SizedBox(height: MediaQuery.of(context).size.height *0.02,),
        Container(child: Text("Appuyer pour prendre \nune photo",textAlign: TextAlign.center,style: TextStyle(fontFamily: "Poppins",fontSize: MediaQuery.of(context).size.width *0.04)),),
SizedBox(height: MediaQuery.of(context).size.height *0.01,),
GestureDetector(
  child: photo_rapport==null?Container(
      child: Lottie.asset("assets/animations/Add new.json",height: MediaQuery.of(context).size.height *0.20)):Container(
    height: MediaQuery.of(context).size.height *0.15,
    child: Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.green,width: MediaQuery.of(context).size.width *0.007,),borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.02))),
      child:ClipRRect(child: photo_rapport,),),),
  onTap: (){
    prendre_photo();
  },

),
        SizedBox(height: MediaQuery.of(context).size.height *0.02,),
          Container(
          height: MediaQuery.of(context).size.height *0.1,
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.04,right: MediaQuery.of(context).size.width *0.04),
          child: TextFormField(
            controller: description,
            maxLines: 200,
            decoration: InputDecoration(
            hintText: "DESCRIPTION",

suffixIcon: IconButton(onPressed: ()async{
  if(photo==null|| description.text.isEmpty){
    Navigator.pop(context);
    message_champ_vide();
  }else{

    await sauvegarder_rapports();
    Navigator.pop(context);
  }

}, icon: Icon(Icons.send,color: Colors.black,)),
hintStyle: TextStyle(fontFamily: "Poppins"),
            enabledBorder: OutlineInputBorder(
borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.03))
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.03))
            )
          ),
        ),)
      ],),
    )));
  }
  @override
  void initState(){
  super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(

        child: Column(
          children: [

            SizedBox(height: MediaQuery.of(context).size.height *0.05,),
Container(
  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.020,right: MediaQuery.of(context).size.width *0.020),
  child: Row(

  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [

    Container(
        child:IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back,color: Colors.black,size: MediaQuery.of(context).size.width *0.08,))
    ),

    Container(child: Text("RAPPORT",style: TextStyle(fontFamily: "Poppins",fontSize: MediaQuery.of(context).size.width *0.05),),),

    Container(
      child: IconButton(onPressed: (){
      }, icon: Icon(Icons.note_alt_outlined,color: Colors.transparent,size: MediaQuery.of(context).size.width *0.08,)),)
  ],),),

SizedBox(height:MediaQuery.of(context).size.height *0.035)
,Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.black38)),
              width: MediaQuery.of(context).size.width *0.6,
              height: MediaQuery.of(context).size.height *0.002,),



            Container(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.05,right: MediaQuery.of(context).size.width *0.01),
              height: MediaQuery.of(context).size.height *0.84,width: MediaQuery.of(context).size.width *1,
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height *0.03,),
                  Container(child: Text("AJOUTER UN RAPPORT",style: TextStyle(fontFamily: "Poppins",fontSize: MediaQuery.of(context).size.width *0.06),),),
                  SizedBox(height: MediaQuery.of(context).size.height *0.06,),
                  Container(child: Text("Appuyer pour prendre \nune photo",textAlign: TextAlign.center,style: TextStyle(fontFamily: "Poppins",fontSize: MediaQuery.of(context).size.width *0.04)),),
                  SizedBox(height: MediaQuery.of(context).size.height *0.05,),
                  GestureDetector(
                    child: photo_rapport==null?Container(
                        child: Lottie.asset("assets/animations/Add new.json",height: MediaQuery.of(context).size.height *0.20)):Container(
                      height: MediaQuery.of(context).size.height *0.21,
                      child: Container(
                        decoration: BoxDecoration(border: Border.all(color: Colors.green,width: MediaQuery.of(context).size.width *0.007,),borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.02))),
                        child:ClipRRect(child: photo_rapport,),),),
                    onTap: (){
                      prendre_photo();
                    },

                  ),
                  SizedBox(height: MediaQuery.of(context).size.height *0.05,),
                  Container(
                    height: MediaQuery.of(context).size.height *0.1,
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.04,right: MediaQuery.of(context).size.width *0.04),
                    child: TextFormField(
                      controller: description,
                      maxLines: 200,
                      decoration: InputDecoration(
                          hintText: "DESCRIPTION",

                          suffixIcon: IconButton(onPressed: ()async{
                            if(photo==null|| description.text.isEmpty){
                              Navigator.pop(context);
                              message_champ_vide();
                            }else{

                              await sauvegarder_rapports();
                              Navigator.pop(context);
                            }

                          }, icon: Icon(Icons.send,color: Colors.green,)),
                          hintStyle: TextStyle(fontFamily: "Poppins"),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.03))
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.03))
                          )
                      ),
                    ),)
                ],),),


        ],),
      ),
    );
  }
}
