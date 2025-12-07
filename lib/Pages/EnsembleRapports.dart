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
  void message_mot_de_passe_incorrect(){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(seconds: 1),backgroundColor: Colors.transparent,content: GestureDetector(
        child: Container(
          height: MediaQuery.of(context).size.height *0.1,
          width: MediaQuery.of(context).size.width *1,
          decoration: BoxDecoration(color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.06))
          ),
          child: ListTile(

            title: Text("INCORRECT",style: TextStyle(color: Colors.white,fontFamily: "Poppins"),),
            subtitle: Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.01),
              child: Text("REESSAYEZ",style: TextStyle(color: Colors.white70,fontFamily: "Poppins"),),),
            leading: Icon(Icons.dangerous,size: MediaQuery.of(context).size.width *0.15,color: Colors.white,),
          ),
        )
    )));
  }
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
  Future <void> verifier_mot_de_passe() async{
    showModalBottomSheet(backgroundColor:Colors.transparent,context: context, builder: (context)=>SingleChildScrollView(child:Container(height: MediaQuery.of(context).size.height *0.6,width: MediaQuery.of(context).size.width *1,decoration: BoxDecoration(color: Colors.white,border: Border(top: BorderSide(color: Colors.green,width: MediaQuery.of(context).size.width *0.05)),
      borderRadius: BorderRadius.only(topLeft: Radius.circular(MediaQuery.of(context).size.width *0.6),topRight: Radius.circular(MediaQuery.of(context).size.width *0.6)),

    ),child: Column(
      children: [
        Container(width: MediaQuery.of(context).size.width *1,),
        SizedBox(height: MediaQuery.of(context).size.height *0.06,),
        Lottie.asset("assets/animations/Warning animation.json"),
        SizedBox(height: MediaQuery.of(context).size.height *0.04,),
        Container(child: Text("Saisissez votre \nmot de passe actuel : ",textAlign: TextAlign.center,style: TextStyle(fontFamily: "Poppins",fontSize: MediaQuery.of(context).size.width *0.05),),),
        SizedBox(height: MediaQuery.of(context).size.height *0.04,),
        Container(
          height: MediaQuery.of(context).size.height *0.07,
          width: MediaQuery.of(context).size.width *0.7,
          child: TextFormField(
            style: TextStyle(fontFamily: "Poppins"),
            controller: mot_de_passe,
            decoration: InputDecoration(
                hintText: "Mot de passe",
                hintStyle: TextStyle(fontFamily: "Poppins",color: Colors.black38),
                prefixIcon: Icon(Icons.lock),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.065))
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.065))
                )
            ),),),
        SizedBox(height: MediaQuery.of(context).size.height *0.04,),
        Container(

          child: ElevatedButton(onPressed: (){
            if(mot_de_passe.text!="fresco2.0"){
              Navigator.pop(context);
              message_mot_de_passe_incorrect();
            }
            else{
              setState(() {
                rapport_description=[];
                longitude_tableau=[];
                latitude_tableau=[];
                photo_tableau=[];
                date_tableau=[];
                photo_rapport;
sauvegarder_rapports();
              });
            Navigator.pop(context);
            }
          }, child: Text("VERIFIER",style: TextStyle(fontFamily:"Poppins",color: Colors.white,fontSize: MediaQuery.of(context).size.width *0.05),),style: ElevatedButton.styleFrom(backgroundColor: Colors.green),),)
      ],
    ),)));
  }
  void message_de_validation(){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(seconds: 1),backgroundColor: Colors.transparent,content: GestureDetector(
        onTap: (){
          verifier_mot_de_passe();

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
  Future <void> charger_donnee()async{
    var perfs=await SharedPreferences.getInstance();
    setState(() {
      identifiant= perfs.getInt("identifiant")??0;
      rapport_description= perfs.getStringList("rapport_description")??[];
      longitude_tableau= perfs.getStringList("longitude_tableau")??[];
      latitude_tableau= perfs.getStringList("latitude_tableau")??[];
      date_tableau=perfs.getStringList("date_tableau")??[];

    });

    print(identifiant);
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
void ajouter_description() async {
  setState(() {
    String loca_longitude=widget.latitude.toString();
    String loca_latitude=widget.longitude.toString();
    rapport_description.add(description.text);
    latitude_tableau.add(loca_latitude);
    longitude_tableau.add(loca_longitude);
    date_tableau.add(DateTime.now().toString());

  });
  print(date_tableau);
  print(rapport_description);

  print(latitude_tableau);
  print(longitude_tableau);
  description.clear();
  setState(() {
    photo_rapport=null;
  });
  await Gal.putImage(photo.path);
  Navigator.pop(context);


}
void message_de_suffisance(){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(seconds: 1),backgroundColor: Colors.transparent,content: Container(
    height: MediaQuery.of(context).size.height *0.1,
    width: MediaQuery.of(context).size.width *1,
    decoration: BoxDecoration(color: Colors.red,
    borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.06))
    ),
child: ListTile(title: Text("LIMITE ATTEINTE",style: TextStyle(color: Colors.white,fontFamily: "Poppins"),),
  subtitle: Text("VEUILLEZ ENVOYER VOS RAPPORTS",style: TextStyle(color: Colors.white70,fontFamily: "Poppins"),),
  leading: Icon(Icons.dangerous_outlined,size: MediaQuery.of(context).size.width *0.15,color: Colors.white,),
),
    
  )));
}
  void modifier_rapport(int index)  {
  description.text=rapport_description[index];
    showModalBottomSheet(backgroundColor: Colors.transparent,context: context, builder: (context)=>SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height *0.55,
          width: MediaQuery.of(context).size.width *1,
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.green,width: 20)),
              borderRadius: BorderRadius.only(topRight: Radius.circular(MediaQuery.of(context).size.width *1),topLeft: Radius.circular(MediaQuery.of(context).size.width *1)),color: Colors.white),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height *0.03,),
              Container(child: Text("MODIFIER \nVOTRE RAPPORT",textAlign: TextAlign.center,style: TextStyle(fontFamily: "Poppins",fontSize: MediaQuery.of(context).size.width *0.06),),),
              SizedBox(height: MediaQuery.of(context).size.height *0.02,),
              Container(child: Text("Appuyer pour prendre \nune nouvelle photo",textAlign: TextAlign.center,style: TextStyle(fontFamily: "Poppins",fontSize: MediaQuery.of(context).size.width *0.04)),),
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
                        rapport_description[index]=description.text;
                        await sauvegarder_rapports();
                        Navigator.pop(context);

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
    ajouter_description();
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
  charger_donnee();
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
      decoration: BoxDecoration(border: Border.all(color: Colors.lightGreen,width:MediaQuery.of(context).size.width *0.006 ),borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *1))),
      child: IconButton(onPressed: (){
        if(rapport_description.length==10){
message_de_suffisance();
        }else{
          ajouter_rapport();
        }

      }, icon: Icon(Icons.note_alt_outlined,color: Colors.green,size: MediaQuery.of(context).size.width *0.08,)),)
  ],),),
            rapport_description.length==10?Container(

              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.01),
              child: ElevatedButton(onPressed: ()async{
message_de_validation();
await sauvegarder_rapports();
              }, child: Text("VALIDER",style: TextStyle(color: Colors.white,fontFamily: "Poppins"),),style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrangeAccent),),
            ):Container(),
SizedBox(height:MediaQuery.of(context).size.height *0.035)
,Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.black38)),
              width: MediaQuery.of(context).size.width *0.6,
              height: MediaQuery.of(context).size.height *0.002,),



            Container(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.05,right: MediaQuery.of(context).size.width *0.01),
              height: MediaQuery.of(context).size.height *0.84,width: MediaQuery.of(context).size.width *1,
              child: rapport_description.length==0?GestureDetector(child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height *0.06,),
                        Container(child: Text("AUCUNE INFORMATION \nDISPONIBLE VEUILLEZ \nSAISIR UN RAPPORT",textAlign: TextAlign.center,style: TextStyle(fontFamily: "Poppins2",fontSize: MediaQuery.of(context).size.width *0.05),),),
                        Container(
                          child: Lottie.asset("assets/animations/Warning animation.json",height: MediaQuery.of(context).size.height *0.2),),
                        Container(child: ElevatedButton(onPressed: ()async{

                          Navigator.push(context, MaterialPageRoute(builder: (context)=>EnsemblerapportsPage(latitude:widget.latitude,longitude:widget.longitude)));
                        }, child: Text("AJOUTER",style: TextStyle(color: Colors.white,fontFamily: "Poppins"),),style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange[400]),),)
                      ],),
                  ))):ListView.builder(itemCount: rapport_description.length,itemBuilder: (context, index) =>
                  ListTile(
                    leading: IconButton(onPressed: (){
                      modifier_rapport(index);
                    }, icon: Icon(Icons.add_circle_outline_rounded,color: Colors.green,size: MediaQuery.of(context).size.width *0.1,)),
                    title: Text("Rapport ${index+1}",style: TextStyle(fontFamily: "Poppins"),),
                    subtitle: Text("latitude: ${latitude_tableau[index]},longitude : ${longitude_tableau[index]}",style: TextStyle(fontFamily: "Poppins",color: Colors.green),),
                    trailing: Container(
                      decoration: BoxDecoration(border: Border.all(color: Colors.black,),borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *1))),
                      child: CircleAvatar(backgroundColor: Colors.white,child: Icon(Icons.arrow_forward_sharp,color: Colors.green,),),
                    ),onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PageRapport(description:rapport_description[index],latitude:latitude_tableau[index],longitude:longitude_tableau[index],index:index,date:date_tableau[index])));
                  },
                  ),
              ),),


        ],),
      ),
    );
  }
}
