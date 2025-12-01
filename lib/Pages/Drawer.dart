import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:hackaton_conducteur/Pages/Acceuil.dart';
import 'package:hackaton_conducteur/Pages/Menu.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}
Future <void> redirecion() async{
  var perfs=await SharedPreferences.getInstance();
  perfs.setBool("rediction_page", true);
}
class _DrawerPageState extends State<DrawerPage> {
  @override
  void initState(){
    super.initState();
    redirecion();
  }
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
        menuBackgroundColor: Colors.white,
        mainScreenTapClose: true,
        angle: 0,
        slideWidth: MediaQuery.of(context).size.width *0.8,
        showShadow: true,
        shadowLayer1Color: Colors.green[200],
        shadowLayer2Color: Colors.green[300],
        menuScreen: MenuPage(), mainScreen: AcceuilPage());
  }
}
