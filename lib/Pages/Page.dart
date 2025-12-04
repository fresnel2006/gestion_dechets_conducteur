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
        Column(children: [
          Container(child: Text(widget.description.toString()),),
          Container(child: Text(widget.latitude.toString()),),
          Container(child: Text(widget.longitude.toString())),
          Container(
height: MediaQuery.of(context).size.height *0.22,
            decoration: BoxDecoration(),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.06)),
              child:Container(
                child: Text(widget.description.toString())),),)
        ],),),
    );
  }
}
