import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hackaton_conducteur/Pages/Redirection.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class InscriptionPage extends StatefulWidget {
  const InscriptionPage({super.key});

  @override
  State<InscriptionPage> createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<InscriptionPage> {
  final nom_chef=TextEditingController();
  final numero_chef=TextEditingController();
  final mot_de_passe_chef=TextEditingController();

  bool couleur_bordure1=true;
  bool couleur_bordure2=true;
  bool afficher_mot_de_passe=true;
var data;
Future <void>  connexion() async{
    final url = Uri.parse("http://192.168.1.10:8000/verifier_conducteur");
    var message = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "numero": numero_chef.text,
          "mot_de_passe": mot_de_passe_chef.text
        })
    );
    data = jsonDecode(message.body);
    print(data["statut"]);


}
  Future <void> sauvegarde_de_redirection() async {
    var perfs=await SharedPreferences.getInstance();
    perfs.setBool("rediction_page", true);
    perfs.setInt("identifiant",data["resultat"][0][0]);
  }
  void message_erreur_conducteur(){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(seconds: 1),backgroundColor: Colors.transparent,content: GestureDetector(
        child: Container(
          height: MediaQuery.of(context).size.height *0.1,
          width: MediaQuery.of(context).size.width *1,
          decoration: BoxDecoration(color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.06))
          ),
          child: ListTile(
            title: Text("CONDUCTEUR INCONNU",style: TextStyle(color: Colors.white,fontFamily: "Poppins"),),
            subtitle: Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.01),
              child: Text("REESSAYEZ",style: TextStyle(color: Colors.white70,fontFamily: "Poppins"),),),
            leading: Icon(Icons.dangerous,size: MediaQuery.of(context).size.width *0.15,color: Colors.white,),
          ),
        )
    )));
  }
  void messagecode1(){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(milliseconds: 1200),backgroundColor: Colors.transparent,content: Container(
      height: MediaQuery.of(context).size.height *0.11,
      decoration: BoxDecoration(
          color: Colors.green,
          borderRadius:BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.06))
      ),
      child: ListTile(leading:Icon(Icons.check_circle_outline,size: MediaQuery.of(context).size.width *0.13,color: Colors.white,),title: Text("INSCRIPTION EFFECTUE",style: TextStyle(color: Colors.white,fontFamily: "Poppins2"),),
        subtitle: Container(margin:EdgeInsets.only(top: MediaQuery.of(context).size.height *0.02),decoration:BoxDecoration(color:Colors.white,border: Border.all(color: Colors.white),borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width *0.02)),child: Text("Merci!",textAlign: TextAlign.center,style: TextStyle(color: Colors.green,fontFamily: "Poppins2"),),), ),),
    ));
  }
  void messagecode2(){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(milliseconds: 1200),backgroundColor: Colors.transparent,content: Container(
      height: MediaQuery.of(context).size.height *0.11,
      decoration: BoxDecoration(
          color: Colors.green,
          borderRadius:BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *0.06))
      ),
      child: ListTile(leading:Icon(Icons.dangerous_outlined,size: MediaQuery.of(context).size.width *0.13,color: Colors.white,),title: Text("ECHOUE",style: TextStyle(color: Colors.white,fontFamily: "Poppins2"),),
        subtitle: Container(margin:EdgeInsets.only(top: MediaQuery.of(context).size.height *0.02),decoration:BoxDecoration(color:Colors.white,border: Border.all(color: Colors.white),borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width *0.02)),child: Text("Merci!",textAlign: TextAlign.center,style: TextStyle(color: Colors.green,fontFamily: "Poppins2"),),), ),),
    ));
  }

  void verification() async{

    if(numero_chef.text.trim().isEmpty||numero_chef.text.length<10||numero_chef.text.length>10){
      setState(() {
        couleur_bordure1=false;
      });
    }
    if(numero_chef.text.length==10){
      setState(() {
        couleur_bordure1=true;
      });
    }
    if(numero_chef.text.length==10 && mot_de_passe_chef.text.isNotEmpty && !mot_de_passe_chef.text.contains(" ")) {
      await connexion();
      if(data["statut"]=="succes"){
        await sauvegarde_de_redirection();
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>RedirectionPage()), (route)=>false);
      }else{
        message_erreur_conducteur();
        print("rien");
        }
    }
    if(mot_de_passe_chef.text.trim().isEmpty || mot_de_passe_chef.text.contains(" ")){
      setState(() {
        couleur_bordure2=false;
      });
    }
    if(mot_de_passe_chef.text.isNotEmpty && !mot_de_passe_chef.text.contains(" ")){
      setState(() {
        couleur_bordure2=true;
      });
    }
  }


  @override
    void dispose(){
      nom_chef.dispose();
      numero_chef.dispose();
      mot_de_passe_chef.dispose();
      super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //Couleur de fond
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        //Pour aligner verticalement les elements
        child: Stack(
          children: [
            Column(
            children: [
              //Pour permettre de centrer les elements
              Container(width: MediaQuery.of(context).size.width *1,),
              //Image de fond
              Container(
                child: Image.asset("assets/images/image_equipe.png",height: MediaQuery.of(context).size.height *0.4,width: MediaQuery.of(context).size.width *1,),
              ),

              Container(
                width: MediaQuery.of(context).size.width *0.7,
                height: MediaQuery.of(context).size.height *0.065,
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.02,right: MediaQuery.of(context).size.width *0.02),
//Pour la saisie du numero
                child: TextFormField(
                  style: TextStyle(fontFamily: "Poppins"),
                  controller: numero_chef,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  cursorColor: Color(0xFF292D3E),
                  decoration: InputDecoration(
                    hintText: "Numero du chef",
hintStyle: TextStyle(color: Colors.black54,fontFamily: "Poppins"),
                    prefixIcon: Icon(FontAwesomeIcons.hashtag,size: MediaQuery.of(context).size.width *0.045,color: Color(0xFF292D3E)),

                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(MediaQuery.of(context).size.width *0.03)
                        ),borderSide: BorderSide(width: MediaQuery.of(context).size.width *0.007,color: couleur_bordure1?Colors.green:Colors.red)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(MediaQuery.of(context).size.width *0.03)
                      ),
                        borderSide: BorderSide(color: couleur_bordure1?Colors.green:Colors.red,width: MediaQuery.of(context).size.width *0.007,)
                    ),
                  ),
                ),
              ),SizedBox(height: MediaQuery.of(context).size.height *0.02,),
              Container(
                width: MediaQuery.of(context).size.width *0.7,
                height: MediaQuery.of(context).size.height *0.065,
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.02,right: MediaQuery.of(context).size.width *0.02),
//Pour la saisie du numero
                child: TextFormField(
                  style: TextStyle(fontFamily: "Poppins"),
                  controller: mot_de_passe_chef,
obscureText: afficher_mot_de_passe,
                  cursorColor: Color(0xFF292D3E),
                  decoration: InputDecoration(
                    hintText: "Mot de passe",
                    hintStyle: TextStyle(color: Colors.black54,fontFamily: "Poppins"),
suffixIcon: IconButton(onPressed: (){
  setState(() {
    afficher_mot_de_passe=!afficher_mot_de_passe;
  });
}, icon: afficher_mot_de_passe?Icon(CupertinoIcons.eye):Icon(CupertinoIcons.eye_slash),color:Color(0xFF292D3E)),
                    prefixIcon: Icon(FontAwesomeIcons.lock,size: MediaQuery.of(context).size.width *0.045,color: Color(0xFF292D3E)),

                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(MediaQuery.of(context).size.width *0.03)
                        ),borderSide: BorderSide(width: MediaQuery.of(context).size.width *0.007,color: couleur_bordure2?Colors.green:Colors.red)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(MediaQuery.of(context).size.width *0.03)
                        ),
                        borderSide: BorderSide(color: couleur_bordure2?Colors.green:Colors.red,width: MediaQuery.of(context).size.width *0.007,)
                    ),
                  ),
                ),
              ),SizedBox(height: MediaQuery.of(context).size.height *0.04,),

    //Bouton d'inscription
              Container(child: ElevatedButton(onPressed: () {


verification();

              }, child: Text("SE CONNECTER",style: TextStyle(color: Colors.white,fontFamily: "Poppins"),),style: ElevatedButton.styleFrom(backgroundColor: Colors.green),),),
              SizedBox(height: MediaQuery.of(context).size.height *0.02,),

              //animation
              Container(child: Lottie.asset("assets/animations/Truck Green Blue.json",height: MediaQuery.of(context).size.height *0.2,),),


            ],),

          ],),
      ),
    );
  }
}
