import 'package:flutter/material.dart';
import 'package:hackaton_conducteur/Pages/Acceuil.dart';
import 'package:hackaton_conducteur/Pages/Drawer.dart';
import 'package:hackaton_conducteur/Pages/Inscription.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RedirectionPage extends StatefulWidget {
  const RedirectionPage({super.key});

  @override
  State<RedirectionPage> createState() => _RedirectionPageState();
}



class _RedirectionPageState extends State<RedirectionPage> {
  var valeur_de_redirection;
  Future <void> charger_donnee()async{
    var perfs=await SharedPreferences.getInstance();
    setState(() {
      valeur_de_redirection=perfs.getBool("rediction_page")??false;
    });
    if(valeur_de_redirection==false){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>InscriptionPage()));
    }else{
      Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawerPage()));

    }
    print(valeur_de_redirection);
  }
  @override
  void initState(){
    super.initState();
    charger_donnee();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: Column(
  mainAxisAlignment: MainAxisAlignment.center,

  children: [
    Container(width: MediaQuery.of(context).size.width *1,),
    Container(child: Lottie.asset("assets/animations/chargement.json"),),
    Container(child: Text("CHARGEMENT ...",style: TextStyle(fontFamily: "Poppins"),),)
  ],),
    );
  }
}
