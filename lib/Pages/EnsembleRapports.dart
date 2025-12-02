import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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

  Future <void> envoyer_rapport() async{
    for (int i=0;i<=10;i++){

    }
    try{
    final url=Uri.parse("");
    var message=await http.post(url,headers: {"Content-Type":"application/json"},
    body: {

    }
    );
        }catch(e){

    }

  }
  Future <void> charger_donnee()async{
    var perfs=await SharedPreferences.getInstance();
    int? valeur_de_redirection=perfs.getInt("identifiant");
    print(valeur_de_redirection);
  }
List <String> rapport_description=[];
List <double> longitude_tableau=[];
List <double> latitude_tableau=[];
List <String> photo_tableau=[];
final description=TextEditingController();
var photo_rapport;


Future <void> prendre_photo() async{
  var photo=await ImagePicker().pickImage(source: ImageSource.camera);
  setState(() async{
    photo_rapport= await Image.file(File(photo!.path));
  });
}
void ajouter_description(){
  String valeur=description.text;
  setState(() {
    double loca_longitude=widget.latitude;
    double loca_latitude=widget.longitude;
    rapport_description.add(valeur);
    latitude_tableau.add(loca_latitude);
    longitude_tableau.add(loca_longitude);
  });
  print(rapport_description);
  print(valeur);
  print(latitude_tableau);
  print(longitude_tableau);
  description.clear();
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
  void ajouter_rapport() {
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
        Container(child: Text("Appuyer pour prendre une photo",style: TextStyle(fontFamily: "Poppins",fontSize: MediaQuery.of(context).size.width *0.04)),),

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

),Container(
          height: MediaQuery.of(context).size.height *0.1,
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.04,right: MediaQuery.of(context).size.width *0.04),
          child: TextFormField(
            controller: description,
            maxLines: 200,
            decoration: InputDecoration(
            hintText: "DESCRIPTION",
suffixIcon: IconButton(onPressed: (){
ajouter_description();
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
              child: ElevatedButton(onPressed: (){

              }, child: Text("ENVOYER",style: TextStyle(color: Colors.white),),style: ElevatedButton.styleFrom(backgroundColor: Colors.green),),
            ):Container(),
SizedBox(height:MediaQuery.of(context).size.height *0.035)
,Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.black38)),
              width: MediaQuery.of(context).size.width *0.6,
              height: MediaQuery.of(context).size.height *0.002,),



            Container(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.05,right: MediaQuery.of(context).size.width *0.01),
              height: MediaQuery.of(context).size.height *0.84,width: MediaQuery.of(context).size.width *1,
              child: rapport_description.length!=0?ListView.builder(itemCount: rapport_description.length,itemBuilder: (context, index) =>
                  ListTile(
                    title: Text("Rapport ${index+1}",style: TextStyle(fontFamily: "Poppins"),),
                    subtitle: Text("longitude : .....,latitude:.....",style: TextStyle(fontFamily: "Poppins",color: Colors.green),),
                    trailing: Container(
                      decoration: BoxDecoration(border: Border.all(color: Colors.black,),borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *1))),
                      child: CircleAvatar(backgroundColor: Colors.white,child: Icon(Icons.arrow_forward_sharp,color: Colors.green,),),
                    ),onTap: (){
                    print(index);
                  },
                  ),
              ):GestureDetector(child: Container(
                child: SingleChildScrollView(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height *0.06,),
                  Container(child: Text("AUCUNE INFORMATION \nDISPONIBLE VEUILLEZ \nSAISIR UN RAPPORT",textAlign: TextAlign.center,style: TextStyle(fontFamily: "Poppins2",fontSize: MediaQuery.of(context).size.width *0.05),),),
                  Container(
                    child: Lottie.asset("assets/animations/Warning animation.json",height: MediaQuery.of(context).size.height *0.2),),
                    Container(child: ElevatedButton(onPressed: (){
                      ajouter_rapport();
                    }, child: Text("AJOUTER",style: TextStyle(color: Colors.white,fontFamily: "Poppins"),),style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange[400]),),)
                ],),
              ))),),


        ],),
      ),
    );
  }
}
