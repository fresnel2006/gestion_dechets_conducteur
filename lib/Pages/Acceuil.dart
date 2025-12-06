import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:hackaton_conducteur/Pages/EnsembleRapports.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:shared_preferences/shared_preferences.dart';

class AcceuilPage extends StatefulWidget {
  const AcceuilPage({super.key});

  @override
  State<AcceuilPage> createState() => _AcceuilPageState();
}

var donnee;

class _AcceuilPageState extends State<AcceuilPage> {
  var identifiant;
  var data;
  Future<void> avoir_trajet() async{

    final url=Uri.parse("http://192.168.1.27:8000/prendre_trajet");
    var message = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "id_trajet": identifiant.toString(),
        })
    );
    data = jsonDecode(message.body);
    print(data["resultat"][0][1]);

  }
  Future <void> charger_donnee() async {
    var perfs=await SharedPreferences.getInstance();
    setState(() {
      identifiant=perfs.getInt("identifiant")??0;
    });
    print(identifiant);
  }
  double longitude = 0;
  double latitude = 0;
  bool couleur_fond1=true;
  bool couleur_fond2=true;
  bool couleur_fond3=true;
  bool couleur_fond4=true;
  bool couleur_fond5=true;

  // Pour le marqueur de l'utilisateur
  CircleAnnotationManager? _circleAnnotationManager;
  CircleAnnotation? _userCircleAnnotation;

  // NOUVEAU : Pour l'itinéraire
  PolylineAnnotationManager? _polylineAnnotationManager;
  PolylineAnnotation? _routePolyline;

  // Coordonnées de Yopougon
  final double yopougonLat = 5.3364;
  final double yopougonLon = -4.0890;

  bool _isFirstLocationUpdate = true;

  // NOUVELLE FONCTION : Afficher l'itinéraire
  Future<void> afficherItineraire(double yopougonLat,double yopougonLon) async {
    if (latitude == 0 && longitude == 0) {
      print("Position non disponible");
      return;
    }

    final String accessToken = "pk.eyJ1IjoiZnJlc25lbDYwNyIsImEiOiJjbWhrbGx1MzMwOGV4MmtxazdsOWp0dzIxIn0.v02HfvuS1iZnm_-od_niSw";

    final url = Uri.parse(
        "https://api.mapbox.com/directions/v5/mapbox/driving/$longitude,$latitude;$yopougonLon,$yopougonLat?geometries=geojson&access_token=$accessToken");

    try {
      final reponse = await http.get(url);

      if (reponse.statusCode == 200) {
        var data = jsonDecode(reponse.body);

        if (data["routes"] != null && data["routes"].isNotEmpty) {
          var coordinates = data["routes"][0]["geometry"]["coordinates"];

          // Convertir les coordonnées
          List<Position> positions = [];
          for (var coord in coordinates) {
            positions.add(Position(coord[0], coord[1]));
          }

          // Afficher la ligne
          await _afficherLigneItineraire(positions);

          // Centrer la carte
          _mapboxMap.flyTo(
            CameraOptions(
              center: Point(coordinates: Position(
                (longitude + yopougonLon) / 2,
                (latitude + yopougonLat) / 2,
              )),
              zoom: 12,
            ),
            MapAnimationOptions(duration: 2000),
          );

          print("Itinéraire affiché !");
        }
      }
    } catch (e) {
      print("Erreur: $e");
    }
  }

  Future<void> _afficherLigneItineraire(List<Position> positions) async {
    if (_polylineAnnotationManager == null) return;

    // Supprimer l'ancien itinéraire s'il existe
    if (_routePolyline != null) {
      await _polylineAnnotationManager!.delete(_routePolyline!);
    }

    // Créer le nouvel itinéraire
    _routePolyline = await _polylineAnnotationManager!.create(
      PolylineAnnotationOptions(
        geometry: LineString(coordinates: positions),
        lineColor: Colors.blue.value,
        lineWidth: 5.0,
      ),
    );
  }

  Future<void> avoirville() async {
    if (latitude == 0 && longitude == 0) return;

    final url = Uri.parse(
        "https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=$latitude&lon=$longitude&accept-language=fr");
    final reponse = await http.get(
      url,
      headers: {"User-Agent": "hackaton_utilisateur/1.0 (exemple@monmail.com)"},
    );

    if (reponse.statusCode == 200) {
      var message = jsonDecode(reponse.body);
      if (mounted) {
        var address = message["address"];
        String? nomLieu = address["city"] ?? address["town"] ?? address["village"] ?? address["suburb"];
        setState(() {
          donnee = nomLieu ?? "Lieu inconnu";
        });
      }
      print(donnee);
    }
  }

  geolocator.Position? _currentPosition;
  late MapboxMap _mapboxMap;

  @override
  void initState() {
    super.initState();
    MapboxOptions.setAccessToken(
        "pk.eyJ1IjoiZnJlc25lbDYwNyIsImEiOiJjbWhrbGx1MzMwOGV4MmtxazdsOWp0dzIxIn0.v02HfvuS1iZnm_-od_niSw");
    _determinePosition();
    avoirville();
    charger_donnee();

  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    geolocator.LocationPermission permission;

    serviceEnabled = await geolocator.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
      return;
    }

    permission = await geolocator.Geolocator.checkPermission();
    if (permission == geolocator.LocationPermission.denied) {
      permission = await geolocator.Geolocator.requestPermission();
      if (permission == geolocator.LocationPermission.denied) {
        print('Location permissions are denied');
        return;
      }
    }

    if (permission == geolocator.LocationPermission.deniedForever) {
      print('Location permissions are permanently denied');
      return;
    }

    geolocator.Geolocator.getPositionStream(
      locationSettings: const geolocator.LocationSettings(
        accuracy: geolocator.LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((geolocator.Position position) {
      print('Position mise à jour: ${position.latitude}, ${position.longitude}');

      if (mounted) {
        setState(() {
          _currentPosition = position;
          longitude = position.longitude;
          latitude = position.latitude;
        });

        avoirville();
        _updateUserMarker(position);

        if (_isFirstLocationUpdate) {
          _isFirstLocationUpdate = false;

          _mapboxMap.flyTo(
            CameraOptions(
              center: Point(coordinates: Position(position.longitude, position.latitude)),
              zoom: 14,
            ),
            MapAnimationOptions(duration: 1500),
          );
        }
      }
    });
  }

  void _onMapCreated(MapboxMap controller) async {
    _mapboxMap = controller;
    _circleAnnotationManager = await _mapboxMap.annotations.createCircleAnnotationManager();
    _polylineAnnotationManager = await _mapboxMap.annotations.createPolylineAnnotationManager(); // NOUVEAU
  }

  void _updateUserMarker(geolocator.Position position) async {
    if (_circleAnnotationManager == null) return;
    final point = Point(coordinates: Position(position.longitude, position.latitude));

    if (_userCircleAnnotation == null) {
      _userCircleAnnotation = await _circleAnnotationManager!.create(
        CircleAnnotationOptions(
            geometry: point,
            circleColor: Colors.blue.value,
            circleRadius: 8.0,
            circleStrokeColor: Colors.white.value,
            circleStrokeWidth: 2.0),
      );
    } else {
      _userCircleAnnotation!.geometry = point;
      _circleAnnotationManager!.update(_userCircleAnnotation!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MapWidget(
            styleUri: MapboxStyles.MAPBOX_STREETS,
            onMapCreated: _onMapCreated,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.07),
                  decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 1)),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      onPressed: () {
                        ZoomDrawer.of(context)!.toggle();
                      },
                      icon: Icon(Icons.menu, color: Colors.green),
                    ),
                  )),
              Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.07),
                height: MediaQuery.of(context).size.height * 0.065,
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width * 1)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on, color: Colors.red),
                    SizedBox(width: MediaQuery.of(context).size.width *0.01),
                    Text(donnee == null ? "CHARGEMENT...." : "$donnee",style: TextStyle(fontFamily: "Poppins"),),
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.07),
                  decoration: BoxDecoration(border: Border.all(color: Colors.black), shape: BoxShape.circle),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      onPressed: () {
                        if (_currentPosition != null) {
                          _mapboxMap.flyTo(
                            CameraOptions(
                              center: Point(coordinates: Position(_currentPosition!.longitude, _currentPosition!.latitude)),
                              zoom: 14,
                            ),
                            MapAnimationOptions(duration: 1500),
                          );
                        }
                      },
                      icon: Icon(Icons.my_location, color: Colors.green),
                    ),
                  )),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width *1,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: Colors.white70,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(MediaQuery.of(context).size.width * 0.15), topRight: Radius.circular(MediaQuery.of(context).size.width * 0.15))),
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.7),
            child: SingleChildScrollView(child: Column(children: [
              // PREMIER TRAJET - MODIFIÉ POUR AJOUTER L'ITINÉRAIRE
              Stack(
                alignment: AlignmentGeometry.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      avoir_trajet();
                      setState(() {
                        couleur_fond1=!couleur_fond1;
                      });
                      if(couleur_fond2==false || couleur_fond3==false || couleur_fond4==false || couleur_fond5==false){

                        setState(() {
                          couleur_fond2=true;
                          couleur_fond3=true;
                          couleur_fond4=true;
                          couleur_fond5=true;
                        });
                        afficherItineraire(data["resultat"][0][1],data["resultat"][0][2]);
                      }
                      // NOUVEAU : Afficher l'itinéraire vers Yopougon

                    },
                    child: Container(

                      padding:EdgeInsets.only(top: MediaQuery.of(context).size.height *0.015),
                      margin:EdgeInsets.only(bottom:MediaQuery.of(context).size.height *0.02,top: MediaQuery.of(context).size.height *0.03),

                      height: MediaQuery.of(context).size.height *0.11,
                      width: MediaQuery.of(context).size.width *0.7,
                      decoration: BoxDecoration(

                          color: couleur_fond1?Colors.green[400]:Colors.orange,
                          border: Border(bottom: BorderSide(color: Colors.black,width: MediaQuery.of(context).size.width *0.007)),
                          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width *1)

                      ),
                      child: ListTile(subtitle: Text("DISTANCE",style: TextStyle(fontFamily: "Poppins",color: Colors.white54),),title: Text("TRAJET 1",style: TextStyle(color: Colors.white,fontFamily: "Poppins"),),
                        leading: CircleAvatar(radius: MediaQuery.of(context).size.width *0.1,child: Lottie.asset("assets/animations/Truck Green Blue.json"),backgroundColor: Colors.white,),),

                    ),),
                  Positioned(top:MediaQuery.of(context).size.height *0.06,right:MediaQuery.of(context).size.width *0.07,child: Container(decoration:BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *1)),border: Border.all(color: Colors.green)),
                    child:CircleAvatar(backgroundColor: Colors.white,),))
                ],
              ),
              // LES AUTRES TRAJETS RESTENT INCHANGÉS
              Stack(
                alignment: AlignmentGeometry.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        couleur_fond2=!couleur_fond2;
                      });
                      if(couleur_fond1==false || couleur_fond3==false || couleur_fond4==false || couleur_fond5==false){
                        setState(() {
                          couleur_fond1=true;
                          couleur_fond3=true;
                          couleur_fond4=true;
                          couleur_fond5=true;
                        });
                      }
                      afficherItineraire(data["resultat"][0][3],data["resultat"][0][4]);
                    },
                    child: Container(
                      padding:EdgeInsets.only(top: MediaQuery.of(context).size.height *0.015),
                      margin:EdgeInsets.only(bottom:MediaQuery.of(context).size.height *0.02),
                      height: MediaQuery.of(context).size.height *0.11,
                      width: MediaQuery.of(context).size.width *0.7,
                      decoration: BoxDecoration(

                          color: couleur_fond2?Colors.green[400]:Colors.orange,
                          border: Border(bottom: BorderSide(color: Colors.black,width: MediaQuery.of(context).size.width *0.007)),
                          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width *1)

                      ),
                      child: ListTile(subtitle: Text("DISTANCE ",style: TextStyle(fontFamily: "Poppins",color: Colors.white54),),title: Text("TRAJET ",style: TextStyle(color: Colors.white,fontFamily: "Poppins"),),
                        leading: CircleAvatar(radius: MediaQuery.of(context).size.width *0.1,child: Lottie.asset("assets/animations/Truck Green Blue.json"),backgroundColor: Colors.white,),),

                    ),),
                  Positioned(top:MediaQuery.of(context).size.height *0.03,right:MediaQuery.of(context).size.width *0.07,child: Container(decoration:BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *1)),border: Border.all(color: Colors.green)),
                    child:CircleAvatar(backgroundColor: Colors.white,),))
                ],
              ),Stack(
                alignment: AlignmentGeometry.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        couleur_fond3=!couleur_fond3;
                      });
                      if(couleur_fond2==false || couleur_fond1==false || couleur_fond4==false || couleur_fond5==false){
                        setState(() {
                          couleur_fond2=true;
                          couleur_fond1=true;
                          couleur_fond4=true;
                          couleur_fond5=true;
                        });
                      }
                      afficherItineraire(data["resultat"][0][9],data["resultat"][0][10]);
                    },
                    child: Container(
                      padding:EdgeInsets.only(top: MediaQuery.of(context).size.height *0.015),
                      margin:EdgeInsets.only(bottom:MediaQuery.of(context).size.height *0.02),
                      height: MediaQuery.of(context).size.height *0.11,
                      width: MediaQuery.of(context).size.width *0.7,
                      decoration: BoxDecoration(

                          color: couleur_fond3?Colors.green[400]:Colors.orange,
                          border: Border(bottom: BorderSide(color: Colors.black,width: MediaQuery.of(context).size.width *0.007)),
                          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width *1)

                      ),
                      child: ListTile(subtitle: Text("DISTANCE ",style: TextStyle(fontFamily: "Poppins",color: Colors.white54),),title: Text("TRAJET ",style: TextStyle(color: Colors.white,fontFamily: "Poppins"),),
                        leading: CircleAvatar(radius: MediaQuery.of(context).size.width *0.1,child: Lottie.asset("assets/animations/Truck Green Blue.json"),backgroundColor: Colors.white,),),

                    ),),
                  Positioned(top:MediaQuery.of(context).size.height *0.03,right:MediaQuery.of(context).size.width *0.07,child: Container(decoration:BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *1)),border: Border.all(color: Colors.green)),
                    child:CircleAvatar(backgroundColor: Colors.white,),))
                  ,
                ],
              ),Stack(
                alignment: AlignmentGeometry.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        couleur_fond4=!couleur_fond4;
                      });
                      if(couleur_fond2==false || couleur_fond3==false || couleur_fond1==false || couleur_fond5==false){
                        setState(() {
                          couleur_fond2=true;
                          couleur_fond3=true;
                          couleur_fond1=true;
                          couleur_fond5=true;
                        });
                      }
                      afficherItineraire(data["resultat"][0][5],data["resultat"][0][6]);
                    },
                    child: Container(
                      padding:EdgeInsets.only(top: MediaQuery.of(context).size.height *0.015),
                      margin:EdgeInsets.only(bottom:MediaQuery.of(context).size.height *0.02),
                      height: MediaQuery.of(context).size.height *0.11,
                      width: MediaQuery.of(context).size.width *0.7,
                      decoration: BoxDecoration(

                          color: couleur_fond4?Colors.green[400]:Colors.orange,
                          border: Border(bottom: BorderSide(color: Colors.black,width: MediaQuery.of(context).size.width *0.007)),
                          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width *1)

                      ),
                      child: ListTile(subtitle: Text("DISTANCE ",style: TextStyle(fontFamily: "Poppins",color: Colors.white54),),title: Text("TRAJET ",style: TextStyle(color: Colors.white,fontFamily: "Poppins"),),
                        leading: CircleAvatar(radius: MediaQuery.of(context).size.width *0.1,child: Lottie.asset("assets/animations/Truck Green Blue.json"),backgroundColor: Colors.white,),),

                    ),),
                  Positioned(top:MediaQuery.of(context).size.height *0.03,right:MediaQuery.of(context).size.width *0.07,child: Container(decoration:BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *1)),border: Border.all(color: Colors.green)),
                    child:CircleAvatar(backgroundColor: Colors.white,),))
                ],
              ),Stack(
                alignment: AlignmentGeometry.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        couleur_fond5=!couleur_fond5;
                      });
                      if(couleur_fond2==false || couleur_fond3==false || couleur_fond4==false || couleur_fond1==false){
                        setState(() {
                          couleur_fond2=true;
                          couleur_fond3=true;
                          couleur_fond4=true;
                          couleur_fond1=true;
                        });
                      }
                      afficherItineraire(data["resultat"][0][7],data["resultat"][0][8]);
                    },
                    child: Container(
                      padding:EdgeInsets.only(top: MediaQuery.of(context).size.height *0.015),
                      margin:EdgeInsets.only(bottom:MediaQuery.of(context).size.height *0.02),
                      height: MediaQuery.of(context).size.height *0.11,
                      width: MediaQuery.of(context).size.width *0.7,
                      decoration: BoxDecoration(

                          color: couleur_fond5?Colors.green[400]:Colors.orange,
                          border: Border(bottom: BorderSide(color: Colors.black,width: MediaQuery.of(context).size.width *0.007)),
                          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width *1)

                      ),
                      child: ListTile(subtitle: Text("DISTANCE ",style: TextStyle(fontFamily: "Poppins",color: Colors.white54),),title: Text("TRAJET ",style: TextStyle(color: Colors.white,fontFamily: "Poppins"),),
                        leading: CircleAvatar(radius: MediaQuery.of(context).size.width *0.1,child: Lottie.asset("assets/animations/Truck Green Blue.json"),backgroundColor: Colors.white,),),

                    ),),
                  Positioned(top:MediaQuery.of(context).size.height *0.03,right:MediaQuery.of(context).size.width *0.07,child: Container(decoration:BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *1)),border: Border.all(color: Colors.green)),
                    child:CircleAvatar(backgroundColor: Colors.white,),))
                ],
              )
            ],)),),
          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.15),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    alignment: AlignmentGeometry.center,
                    height:MediaQuery.of(context).size.height *0.05,
                    width: MediaQuery.of(context).size.width *0.3,
                    decoration:BoxDecoration(
                      color: Colors.white,
                      border:Border.all(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *1))
                    ),
                    child: Text("EQUIPE $identifiant",style: TextStyle(fontFamily: "Poppins",color: Colors.red),) ,),
                  Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height *0.05,
                    width: MediaQuery.of(context).size.width *0.4,
                      decoration:BoxDecoration(
                          color: Colors.white,
                          border:Border.all(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width *1))
                      ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Text("DATE : ",style: TextStyle(fontFamily: "Poppins")),
                      Text("${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",style: TextStyle(fontFamily: "Poppins",color: Colors.green),)
                    ],),
                  ),
                  Container(decoration: BoxDecoration(border: Border.all(color: Colors.black),borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width *1)),child: CircleAvatar(backgroundColor: Colors.white,child: IconButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>EnsemblerapportsPage(latitude:latitude,longitude:longitude)));
                  }, icon: Icon(Icons.note_alt_sharp,color: Colors.red)),),),
                  
                ],),)
        ],
      ),
    );
  }
}