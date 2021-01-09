import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong/latlong.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class MapScreen extends StatefulWidget {
  int index;

  MapScreen(ind) {
    this.index = ind;
  }

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(fournisseurs[widget.index].name),
          backgroundColor: Colors.pink,
          elevation: 20,
        ),
        body: new FlutterMap(
          options: new MapOptions(
            center: new LatLng(fournisseurs[widget.index].centerLat,
                fournisseurs[widget.index].centerLong),
            zoom: fournisseurs[widget.index].zoomba,
          ),
          layers: [
            new TileLayerOptions(
                urlTemplate:
                    "https://api.mapbox.com/styles/v1/tazbaki/ckjohsqjt0d2r19qs4f6zytar/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoidGF6YmFraSIsImEiOiJja2pvZ3lsMnUwZGQzMnNsMTQ4Z2R6ZGxuIn0.g-mkDdKzUZRE8b0zEG0T4Q",
                additionalOptions: {
                  'accessToken':
                      'pk.eyJ1IjoidGF6YmFraSIsImEiOiJja2pvZ3lsMnUwZGQzMnNsMTQ4Z2R6ZGxuIn0.g-mkDdKzUZRE8b0zEG0T4Q',
                  'id': 'mapbox.mapbox-streets-v8'
                }),
            new MarkerLayerOptions(
                markers: fournisseurs[widget.index].boutiques.map((el) {
              print("el is $el");
              return _createMarker(fournisseurs[widget.index].name,
                  boutiques[el].ville, boutiques[el]);
            }).toList())
          ],
        ));
  }

  Marker _createMarker(name, subtitle, boutique) {
    print(
        "data is please : ${boutique.lat} -- ${boutique.long} -- ${boutique.clock} --${boutique.telephone}--${boutique.location},${boutique.adresse}");
    return new Marker(
        width: 80.0,
        height: 90.0,
        point: new LatLng(boutique.lat, boutique.long),
        builder: (context) => Container(
              child: IconButton(
                icon: Icon(FontAwesomeIcons.mapMarkerAlt),
                iconSize: 45.0,
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (builder) {
                        return Scaffold(
                          appBar: AppBar(
                            title: Column(
                              children: [
                                Text(name),
                                Text(
                                  boutique.ville,
                                  style: TextStyle(fontSize: 10.0),
                                )
                              ],
                            ),
                            backgroundColor: Colors.pink,
                            leading: IconButton(
                              icon: Icon(FontAwesomeIcons.mapMarkedAlt),
                              onPressed: () {},
                            ),
                          ),
                          body: Container(
                            child: Center(
                              child: ListView(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 15.0, right: 15.0, bottom: 5.0),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          RaisedButton.icon(
                                              icon:
                                                  Icon(FontAwesomeIcons.phone),
                                              label: Text("Call"),
                                              onPressed: () {
                                                launch(
                                                    "tel://${boutique.telephone}");
                                              }),
                                          RaisedButton.icon(
                                              icon:
                                                  Icon(FontAwesomeIcons.globe),
                                              label: Text("Website"),
                                              onPressed: () {
                                                launch("${boutique.adresse}");
                                              }),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          RaisedButton.icon(
                                              icon: Icon(
                                                  FontAwesomeIcons.facebook),
                                              label: Text("Facebook"),
                                              onPressed: () {
                                                launch("${boutique.facebook}");
                                              })
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(1.0),
                                    child: ListTile(
                                      leading:
                                          Icon(FontAwesomeIcons.mapMarkedAlt),
                                      title: Text(
                                        boutique.location,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.0),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(1.0),
                                    child: ListTile(
                                      leading: Icon(FontAwesomeIcons.clock),
                                      title: Text(
                                        boutique.clock,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.0),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(1.0),
                                    child: ListTile(
                                      leading: Icon(FontAwesomeIcons.globe),
                                      title: Text(
                                        boutique.adresse,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.0),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(1.0),
                                    child: ListTile(
                                      leading: Icon(FontAwesomeIcons.facebook),
                                      title: Text(
                                        boutique.facebook,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.0),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(1.0),
                                    child: ListTile(
                                      leading: Icon(FontAwesomeIcons.phone),
                                      title: Text(
                                        boutique.telephone,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
              ),
            ));
  }

//sbs
  static Boutique b1 = new Boutique(
      lat: 36.84530789831604,
      long: 10.197408830319691,
      location: "Boulevard de la Terre, Tunis 1082",
      clock: "Etablissement ouvert: 09:00-15:00",
      adresse: "http://www.sbsinformatique.com/",
      facebook: "https://www.facebook.com/SBSinformatique/",
      telephone: "+216 37 367 627",
      ville: "Tunis");
//megapc
  static Boutique b2 = new Boutique(
      lat: 36.88137963578576,
      long: 10.258106148126334,
      location: "6 Boulevard de l'Environnement, Tunis 2045",
      clock: "Etablissement ouvert: 10:00-18:00",
      adresse: "http://www.megapc.tn/",
      facebook: "https://www.facebook.com/GoMegaPC/",
      telephone: "+216 23 835 420",
      ville: "Tunis");

  static Boutique b3 = new Boutique(
      lat: 35.84420512498313,
      long: 10.59913988425045,
      location: "Sousse-سوسة",
      clock: "Etablissement ouvert: 08:00-18:00",
      adresse: "http://www.mega-pc.net/",
      facebook: "https://www.facebook.com/GoMegaPC/",
      telephone: "+216 28 087 395",
      ville: "Sousse");
  //wiki
  static Boutique b4 = new Boutique(
      lat: 35.90973513344572,
      long: 10.645858148988829,
      location: "Rue Bechir Sfar N°2 à côté de l'Ecole des Soeurs, Sousse 4000",
      clock: "Etablissement ouvert: 09:00-19:00",
      adresse: "http://www.wiki.tn/",
      facebook: "https://www.facebook.com/WIKIOfficiel",
      telephone: "+216 73 200 452",
      ville: "Sousse");
  static Boutique b5 = new Boutique(
      lat: 35.77169151587987,
      long: 10.113021216615886,
      location: "Rue Habib Thameur, Kairouan",
      clock: "Etablissement ouvert: 08:30-19:00",
      adresse: "http://www.wiki.tn/",
      facebook: "https://www.facebook.com/WIKIOfficiel",
      telephone: "+216 28 540 427",
      ville: "Kairouan");
  static Boutique b6 = new Boutique(
      lat: 36.80773926485048,
      long: 10.2118981731387,
      location: "18 Avenue Martyrs, El Mourouj",
      clock: "Etablissement ouvert: 09:00-19:00",
      adresse: "http://www.wiki.tn/",
      facebook: "https://www.facebook.com/WIKIOfficiel",
      telephone: "+216 79 359 441",
      ville: "Mourouj");
  static Boutique b7 = new Boutique(
      lat: 36.90004373009158,
      long: 10.129500709369688,
      location: "38, Avenue de l'indépendence, saidia - bardo 2000",
      clock: "Etablissement ouvert: 09:00-19:00",
      adresse: "http://www.wiki.tn/",
      facebook: "https://www.facebook.com/WIKIOfficiel",
      telephone: "+216 71 660 830",
      ville: "Bardo");
  //mytek
  static Boutique b8 = new Boutique(
      lat: 36.87085471791034,
      long: 10.21152808070387,
      location: "rue de l'industrie, Tunis 2035",
      clock: "Etablissement ouvert: 08:00-18:00",
      adresse: "https://www.mytek.tn/",
      facebook: "https://www.facebook.com/Mytek.tn",
      telephone: "+216 36 010 010",
      ville: "Tunis");
  static Boutique b9 = new Boutique(
      lat: 36.45455272942149,
      long: 10.743236868782134,
      location:
          "Avenue Ali Belhouane route Dar Chaâbene El Fehri، Nabeul‎ 8011",
      clock: "Etablissement ouvert: 09:00-13:00,14:00-17:00",
      adresse: "https://www.mytek.tn/",
      facebook: "https://www.facebook.com/Mytek.tn",
      telephone: "+216 72 220 666",
      ville: "Nabeul");
  static Boutique b10 = new Boutique(
      lat: 35.83236015011552,
      long: 10.633074326435255,
      location: "Rue El Farabi, Sousse 4000",
      clock: "Etablissement ouvert: 09:00-13:00,14:00-17:00",
      adresse: "https://www.mytek.tn/",
      facebook: "https://www.facebook.com/Mytek.tn",
      telephone: "+216 73 201 801",
      ville: "Sousse");
  static Boutique b11 = new Boutique(
      lat: 36.809469808941984,
      long: 10.179930255301317,
      location: "Avenue de La Liberté, Tunis 1002",
      clock: "Etablissement ouvert: 09:00-13:00,14:00-17:00",
      adresse: "https://www.mytek.tn/",
      facebook: "https://www.facebook.com/Mytek.tn",
      telephone: "+216 71 832 832",
      ville: "Tunis");

  List<Boutique> boutiques = [b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11];

  static Fournisseur f1 = Fournisseur(
      "SBS Informatique", [0], 36.84530789831604, 10.197408830319691, 13.0);
  static Fournisseur f2 = Fournisseur(
      "Mega Pc", [1, 2], 36.319512288619975, 10.389922583376729, 8.0);
  static Fournisseur f3 = Fournisseur(
      "Wiki", [3, 4, 5, 6], 36.20678725799245, 10.185396652642895, 8.0);
  static Fournisseur f4 = Fournisseur(
      "Mytek", [7, 8, 9, 10], 36.20678725799245, 10.185396652642895, 8.0);
  static Fournisseur f5 =
      Fournisseur("Golden", [], 36.20678725799245, 10.185396652642895, 8.0);
  static Fournisseur f6 =
      Fournisseur("tak tek", [], 36.20678725799245, 10.185396652642895, 8.0);
  List<Fournisseur> fournisseurs = [f1, f2, f3, f4, f5, f6];
}

class Fournisseur {
  String name;

  double centerLat;
  double centerLong;
  double zoomba;
  var boutiques = [];

  Fournisseur(name, boutiques, centerLat, centerLong, zoomba) {
    this.name = name;

    this.centerLat = centerLat;
    this.centerLong = centerLong;
    this.zoomba = zoomba;
    this.boutiques = boutiques;
  }

  // Fournisseur.create(Fournisseur f) {
  //   this.name = f.name;
  //   this.subtitle = f.subtitle;
  //   this.boutiques = f.boutiques.map((el) => Boutique.create(el)).toList();
  // }

}

class Boutique {
  double lat;
  double long;
  String location;
  String clock;
  String adresse;
  String facebook;
  String telephone;
  String ville;

  Boutique({lat, long, location, clock, adresse, facebook, telephone, ville}) {
    this.lat = lat;
    this.long = long;
    this.clock = clock;
    this.location = location;
    this.adresse = adresse;
    this.facebook = facebook;
    this.telephone = telephone;
    this.ville = ville;
  }

  // Boutique.create(Boutique b) {
  //   this.lat = b.lat;
  //   this.long = b.long;
  //   this.telephone = b.telephone;
  //   this.adresse = b.adresse;
  //   this.facebook = b.facebook;
  // }
}
