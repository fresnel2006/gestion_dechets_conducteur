import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hackaton_conducteur/Pages/Inscription2.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Copilote2Page extends StatefulWidget {
  const Copilote2Page({super.key});

  @override
  State<Copilote2Page> createState() => _Copilote2PageState();
}

class _Copilote2PageState extends State<Copilote2Page> {
  bool couleur_bordure1=true;
  bool couleur_bordure2=true;

  final nom_copilote2=TextEditingController();
  final numero_copilote2 =TextEditingController();
  Future <void> sauvegarder() async{
    var perfs=await SharedPreferences.getInstance();
    await perfs.setBool("validation2", true);
  }
  void verification(){
    if(nom_copilote2.text.trim().isEmpty||nom_copilote2.text.contains(" ")){
      setState(() {
        couleur_bordure1=false;
      });
    }
    if(numero_copilote2.text.trim().isEmpty||numero_copilote2.text.length<10||numero_copilote2.text.length>10){
      setState(() {
        couleur_bordure2=false;
      });
    }
    if(numero_copilote2.text.length==10){
      setState(() {
        couleur_bordure2=true;
      });
    }
    if(!nom_copilote2.text.contains(" ") && nom_copilote2.text.trim().isNotEmpty){
      setState(() {
        couleur_bordure1=true;
      });
    }
    if(!nom_copilote2.text.contains(" ") && nom_copilote2.text.trim().isNotEmpty &&numero_copilote2.text.length==10) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Inscription2Page()));
      sauvegarder();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.06,left: MediaQuery.of(context).size.width *0.06),
                  child: Row(
                    children: [
IconButton(onPressed: (){
  Navigator.pop(context);
}, icon: Icon(Icons.arrow_back_sharp,size: MediaQuery.of(context).size.width *0.09,color: Colors.black,),),
                      SizedBox(width: MediaQuery.of(context).size.width *0.15,),
                      Text("COPILOTE 2",style: TextStyle(fontFamily: "Poppins",fontSize: MediaQuery.of(context).size.width *0.055),)
                    ],),),
                //Pour permettre de centrer les elements
                Container(width: MediaQuery.of(context).size.width *1,),
                //Image de fond
                Container(
                  child: Lottie.asset("assets/animations/tai-che.json",height: MediaQuery.of(context).size.height *0.4,width: MediaQuery.of(context).size.width *1,),
                ),
                //Pour l'input de la saisie du Nom
                Container(
                  width: MediaQuery.of(context).size.width *0.7,
                  height: MediaQuery.of(context).size.height *0.065,
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.02,right: MediaQuery.of(context).size.width *0.02),
                  child: TextFormField(
                    controller: nom_copilote2,
                    cursorColor: Color(0xFF292D3E),
                    decoration: InputDecoration(
                        hintText:"Nom du copilote 2",
                        prefixIcon: Icon(FontAwesomeIcons.leaf,size: MediaQuery.of(context).size.width *0.040,color: Color(0xFF292D3E),),
                        focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
    Radius.circular(MediaQuery.of(context).size.width *0.03)
    ),
                            borderSide: BorderSide(color: couleur_bordure1?Colors.green:Colors.red,width: MediaQuery.of(context).size.width *0.007,)
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(MediaQuery.of(context).size.width *0.03)
                          ), borderSide: BorderSide(width: MediaQuery.of(context).size.width *0.007,color: couleur_bordure1?Colors.green:Colors.red),
                        )
                    ),
                  ),

                ),SizedBox(height: MediaQuery.of(context).size.height *0.02,),Container(
                  width: MediaQuery.of(context).size.width *0.7,
                  height: MediaQuery.of(context).size.height *0.065,
                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.02,right: MediaQuery.of(context).size.width *0.02),
//Pour la saisie du numero
                  child: TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    controller: numero_copilote2,
                    cursorColor: Color(0xFF292D3E),
                    decoration: InputDecoration(
                      hintText: "Numero du copilote 2 ",
                      prefixIcon: Icon(FontAwesomeIcons.hashtag,size: MediaQuery.of(context).size.width *0.040,color: Color(0xFF292D3E)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(MediaQuery.of(context).size.width *0.03)
                          ),borderSide: BorderSide(width: MediaQuery.of(context).size.width *0.007,color: couleur_bordure2?Colors.green:Colors.red)
                      ),
                      focusedBorder:OutlineInputBorder(
    borderRadius: BorderRadius.all(
    Radius.circular(MediaQuery.of(context).size.width *0.03)
    ),
                          borderSide: BorderSide(color: couleur_bordure2?Colors.green:Colors.red,width: MediaQuery.of(context).size.width *0.007,)
                      ),
                    ),
                  ),
                ),SizedBox(height: MediaQuery.of(context).size.height *0.04,),
                //Bouton d'inscription
                Container(child: ElevatedButton(onPressed: (){
                  verification();

                }, child: Text("VALIDER",style: TextStyle(color: Colors.white),),style: ElevatedButton.styleFrom(backgroundColor: Colors.green),),),
                SizedBox(height: MediaQuery.of(context).size.height *0.02,),

                //animation

              ],)
          ],),
      ),
    );
  }
}
