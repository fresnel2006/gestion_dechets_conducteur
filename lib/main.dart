import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackaton_conducteur/Pages/Acceuil.dart';
import 'package:hackaton_conducteur/Pages/Drawer.dart';
import 'package:hackaton_conducteur/Pages/EnsembleRapports.dart';

import 'package:hackaton_conducteur/Pages/Redirection.dart';
import 'Pages/Inscription.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // Bloquer l’application en portrait uniquement
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body:RedirectionPage(),
      ),
    );
  }
}
