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
                  fournisseurs[widget.index].subtitle, boutiques[el]);
            }).toList())
          ],
        ));
  }

  Marker _createMarker(name, subtitle, boutique) {
    print("data is please : ${boutique.lat} -- ${boutique.long}");
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
                                  subtitle,
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
                                                launch("tel://21213123123");
                                              }),
                                          RaisedButton.icon(
                                              icon:
                                                  Icon(FontAwesomeIcons.globe),
                                              label: Text("Website"),
                                              onPressed: () {}),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          RaisedButton.icon(
                                              icon: Icon(
                                                  FontAwesomeIcons.facebook),
                                              label: Text("Facebook"),
                                              onPressed: () {})
                                        ],
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
                                      leading: Icon(FontAwesomeIcons.phone),
                                      title: Text(
                                        boutique.telephone,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.0),
                                      ),
                                    ),
                                  )
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

  static Boutique b1 = new Boutique(
      lat: 34.056340,
      long: -118.232050,
      telephone: "+216 99 999 999",
      adresse: "Hello world my name is Mohamed",
      facebook: "https://www.facebook.com/7low");

  static Boutique b2 = new Boutique(
      lat: 38.056340,
      long: -118.232050,
      telephone: "+216 99 999 999",
      adresse: "Hello world my name is Taz",
      facebook: "https://www.facebook.com/7low");
  List<Boutique> boutiques = [b1, b2];

  static Fournisseur f1 = Fournisseur(
      "SBS Informatique", "ville", [0, 1], 34.056340, -118.232050, 13.0);
  static Fournisseur f2 =
      Fournisseur("shishi", "ville", [1], 34.056340, -118.232050, 13.0);
  List<Fournisseur> fournisseurs = [f1, f2];
}

class Fournisseur {
  String name;
  String subtitle;
  double centerLat;
  double centerLong;
  double zoomba;
  var boutiques = [];

  Fournisseur(name, subtitle, boutiques, centerLat, centerLong, zoomba) {
    this.name = name;
    this.subtitle = subtitle;
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

  String toString() => "$name - $subtitle";
}

class Boutique {
  double lat;
  double long;
  String telephone;
  String adresse;
  String facebook;
  Boutique({lat, long, telephone, adresse, facebook}) {
    this.lat = lat;
    this.long = long;
    this.telephone = telephone;
    this.adresse = adresse;
    this.facebook = facebook;
  }

  // Boutique.create(Boutique b) {
  //   this.lat = b.lat;
  //   this.long = b.long;
  //   this.telephone = b.telephone;
  //   this.adresse = b.adresse;
  //   this.facebook = b.facebook;
  // }
}
