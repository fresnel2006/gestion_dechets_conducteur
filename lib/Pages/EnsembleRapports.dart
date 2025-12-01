import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class EnsemblerapportsPage extends StatefulWidget {
  const EnsemblerapportsPage({super.key});

  @override
  State<EnsemblerapportsPage> createState() => _EnsemblerapportsPageState();
}

class _EnsemblerapportsPageState extends State<EnsemblerapportsPage> {
List <String> rapport_description=[];
List <double> longitude=[];
List <double> latitude=[];
var photo_rapport;

Future <void> prendre_photo() async{
  var photo=await ImagePicker().pickImage(source: ImageSource.camera);
  setState(() {
    photo_rapport=Image.file(File(photo!.path));
  });
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
  child: photo_rapport==null?Container(child: Lottie.asset("assets/animations/Add new.json",height: MediaQuery.of(context).size.height *0.20)):Container(
    height: MediaQuery.of(context).size.height *0.15,
    child: ClipRRect(child: photo_rapport,),),
  onTap: (){
    prendre_photo();
  },

),Container(
          height: MediaQuery.of(context).size.height *0.1,
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.04,right: MediaQuery.of(context).size.width *0.04),
          child: TextFormField(
            maxLines: 200,
          decoration: InputDecoration(
            hintText: "DESCRIPTION",
suffixIcon: IconButton(onPressed: (){

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
ajouter_rapport();
      }, icon: Icon(Icons.note_alt_outlined,color: Colors.green,size: MediaQuery.of(context).size.width *0.08,)),)
  ],),),
SizedBox(height:MediaQuery.of(context).size.height *0.035)
,Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.black38)),
              width: MediaQuery.of(context).size.width *0.6,
              height: MediaQuery.of(context).size.height *0.002,),
            SizedBox(height:MediaQuery.of(context).size.height *0.02),
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
                    Container(child: ElevatedButton(onPressed: (){
                      ajouter_rapport();
                    }, child: Text("AJOUTER",style: TextStyle(color: Colors.white,fontFamily: "Poppins"),),style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange[400]),),)
                ],),
              ))):ListView.builder(itemCount: rapport_description.length,itemBuilder: (context, index) =>
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
              ),)
        ],),
      ),
    );
  }
}
