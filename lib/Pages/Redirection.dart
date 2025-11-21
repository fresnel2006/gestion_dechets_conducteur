import 'package:flutter/material.dart';
import 'package:hackaton_conducteur/Pages/Acceuil.dart';
import 'package:hackaton_conducteur/Pages/Drawer.dart';
import 'package:hackaton_conducteur/Pages/Inscription.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RedirectionPage extends StatefulWidget {
  const RedirectionPage({super.key});

  @override
  State<RedirectionPage> createState() => _RedirectionPageState();
}
var valeur_de_redirection;

Future <void> charger_donnee()async{
  var perfs=await SharedPreferences.getInstance();
  valeur_de_redirection=perfs.getBool("rediction_page")??false;
}
class _RedirectionPageState extends State<RedirectionPage> {

  @override
  void initState(){
    super.initState();
    charger_donnee();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: LayoutBuilder(builder: (context, constraints) {
  if(valeur_de_redirection==false){
    return InscriptionPage();
  }else{
return AcceuilPage();
  }
},),
    );
  }
}
