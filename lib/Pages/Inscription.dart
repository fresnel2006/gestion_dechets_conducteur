import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

class InscriptionPage extends StatefulWidget {
  const InscriptionPage({super.key});

  @override
  State<InscriptionPage> createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<InscriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//Couleur de fond
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        //Pour aligner verticalement les elements
        child: Column(
          children: [
            //Pour permettre de centrer les elements
            Container(width: MediaQuery.of(context).size.width *1,),
            //Image de fond
            Container(
              child: Image.asset("assets/images/image_equipe.png",height: MediaQuery.of(context).size.height *0.4,width: MediaQuery.of(context).size.width *1,),
            ),
            //Pour l'input de la saisie du Nom
            Container(
              width: MediaQuery.of(context).size.width *0.7,
              height: 50,
              padding: EdgeInsets.only(left: 10,right: 10),
              child: TextFormField(
                cursorColor: Color(0xFF292D3E),
                decoration: InputDecoration(
                    hintText:"Nom du groupe",
                    prefixIcon: Icon(FontAwesomeIcons.leaf,size: 19,color: Color(0xFF292D3E),),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green,width: MediaQuery.of(context).size.width *0.007,)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(MediaQuery.of(context).size.width *0.03)
                      ), borderSide: BorderSide(width: MediaQuery.of(context).size.width *0.007,color: Colors.green),
                    )
                ),
              ),

            ),SizedBox(height: MediaQuery.of(context).size.height *0.02,),Container(
              width: MediaQuery.of(context).size.width *0.7,
              height: 50,
              padding: EdgeInsets.only(left: 10,right: 10),
//Pour la saisie du numero
              child: TextFormField(
                cursorColor: Color(0xFF292D3E),
                decoration: InputDecoration(
                  hintText: "Numero du chef",
                  prefixIcon: Icon(FontAwesomeIcons.hashtag,size: 17,color: Color(0xFF292D3E)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(MediaQuery.of(context).size.width *0.03)
                      ),borderSide: BorderSide(width: MediaQuery.of(context).size.width *0.007,color: Colors.green)
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green,width: MediaQuery.of(context).size.width *0.007,)
                  ),
                ),
              ),
            ),SizedBox(height: MediaQuery.of(context).size.height *0.02,),
            //Bouton d'inscription
            Container(child: ElevatedButton(onPressed: (){}, child: Text("PROCHAINE ETAPE",style: TextStyle(color: Colors.white),),style: ElevatedButton.styleFrom(backgroundColor: Colors.green),),),
            SizedBox(height: MediaQuery.of(context).size.height *0.02,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(color: Color(0xFF292D3E),width: 150,height: 2,),
                Text("OU",style: TextStyle(color: Color(0xFF292D3E)),),
                Container(color: Color(0xFF292D3E),width: 150,height: 2,),
              ],),
            //animation
            Container(child: Lottie.asset("assets/animations/fruit_lance.json",height: MediaQuery.of(context).size.height *0.2,),),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("DEJA UN COMPTE ?",style: TextStyle(color: Color(0xFF292D3E)),),
                TextButton(onPressed: (){}, child: Text("CONNEXION",style: TextStyle(color: Colors.green),))
              ],)
          ],),
      ),
    );
  }
}
