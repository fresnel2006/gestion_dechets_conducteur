import 'dart:convert';

import 'package:flutter/material.dart';

class PageRapport extends StatefulWidget {
    PageRapport({super.key, required this.description, required this.latitude, required this.longitude, required this.index});
var description;
var latitude;
var longitude;
var index;

  @override
  State<PageRapport> createState() => _PageRapportState();
}

class _PageRapportState extends State<PageRapport> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: 
        Column(
          children: [
          SizedBox(height: MediaQuery.of(context).size.height *0.04),
Container(
  padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.width *0.015),
  decoration: BoxDecoration(
  ),
  child: Row(

    children: [
    Container(
      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.02),
      child: IconButton(onPressed: (){
        Navigator.pop(context);
      }, icon: Icon(Icons.arrow_back,color: Colors.black,size: MediaQuery.of(context).size.width *0.08,)),)
    ,
      SizedBox(width: MediaQuery.of(context).size.width *0.23,),
      Container(

        child:Text("Rapport ${widget.index+1}",style: TextStyle(fontFamily: "Poppins",fontSize: MediaQuery.of(context).size.width *0.05),),
          )
    ],)),
          SizedBox(height: MediaQuery.of(context).size.height *0.05),

          Container(
            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.06),
            child:
          Row(
            children: [
            Text("LATITUDE : ",style: TextStyle(color: Colors.green,fontFamily: "Poppins"),),
            Text(widget.latitude.toString(),style: TextStyle(color: Colors.black,fontFamily: "Poppins"),)
          ],),),
          Container(
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.06),
              child: Row(
                children: [
                Text("LONGITUDE : ",style: TextStyle(color: Colors.green,fontFamily: "Poppins")),
                  Text(widget.longitude.toString(),style: TextStyle(color: Colors.black,fontFamily: "Poppins"))
              ],)),
          Container(
            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.06),
            child: Row(
              children: [
Text("DESCRIPTION : ",style: TextStyle(color: Colors.green,fontFamily: "Poppins")),
              
            ],),),
            SizedBox(height: MediaQuery.of(context).size.height *0.03,),
            Container(
              width: MediaQuery.of(context).size.width *0.4,
              decoration: BoxDecoration(border: Border.all(color: Colors.black)),),
            SizedBox(height: MediaQuery.of(context).size.height *0.02,),
            Container(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.04 ,right:MediaQuery.of(context).size.width *0.04 ),
              child: Text(widget.description,style: TextStyle(fontFamily: "Poppins"),),)

        ],),),
    );
  }
}
