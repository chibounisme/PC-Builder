import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pcbuilder/models/fournisseur.dart';
import 'package:pcbuilder/screens/loginscreen.dart';
import 'package:pcbuilder/screens/sbsmapscreen.dart';
import 'package:pcbuilder/utils/utils.dart';

class OrderNow extends StatefulWidget {
  @override
  _OrderNowState createState() => _OrderNowState();
}

class _OrderNowState extends State<OrderNow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Order Now!"),
          backgroundColor: Colors.black,
          elevation: 20,
        ),
        body: GridView.count(
          crossAxisCount: 1,
          childAspectRatio: 3.0,
          children: <Widget>[
            myGridItems(
                "Golden Pc",
                "https://lh3.googleusercontent.com/proxy/2xMZcT3yXtbduQS5pvzhOTHJiUtOFVyozuu1l5ZSLMZ5WrsC-_0EZwPjrqIAUA5QyLIqouFhnva_fuI286Lj2vQhUWoVDNCsW9Zbhi7qlhO5YXnsRXmxJXMQjYK4",
                0xff353839,
                0xff353839,
                context),
            myGridItems(
                "SBS Informatique",
                "https://www.leparisien.fr/resizer/gbtv5s1tpUyS3EaMZVv8wmfsVHQ=/932x582/arc-anglerfish-eu-central-1-prod-leparisien.s3.amazonaws.com/public/3OFN5BKSSH443T2SHDEBDGOBLY.jpg",
                0xff0E1111,
                0xff0E1111,
                context),
            myGridItems(
                "MEGA PC",
                "https://www.sauvesouris.com/wp-content/uploads/2019/07/eda64c0a10fb395884fddec13045439b-696x464.jpg",
                0xff353839,
                0xff353839,
                context),
            myGridItems(
                "WIKI",
                "https://assets.prod-blog.avira.com/wp-content/uploads/2018/04/gaming-pc-2018.jpg",
                0xff0E1111,
                0xff0E1111,
                context),
            myGridItems(
                "MyTeck",
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS99XEavhBfUvIXRdW1HpXAIcSwSDe83h9NGQ&usqp=CAU",
                0xff353839,
                0xff353839,
                context),
            myGridItems(
                "tak tech",
                "https://i2.wp.com/www.element-gaming.eu/wp-content/uploads/2020/06/image-3.png?fit=1280%2C622&ssl=1",
                0xff0E1111,
                0xff0E1111,
                context),
          ],
        ));
  }
}

Widget myGridItems(String gridName, String gridimage, int color1, int color2,
    BuildContext context) {
  return RaisedButton(
    onPressed: () {
      moveToPage(context, SbsMapScreen(fournisseur: f1));
      debugPrint("clicked it");
    },
    padding: EdgeInsets.symmetric(),
    child: Container(
      decoration: BoxDecoration(
          gradient: new LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.topLeft,
        colors: [
          Color(color1),
          Color(color2),
        ],
      )),
      child: Stack(
        children: <Widget>[
          Opacity(
            opacity: 0.3,
            child: Container(
              decoration: new BoxDecoration(
                  image: DecorationImage(
                image: new NetworkImage(gridimage),
                fit: BoxFit.fill,
              )),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  gridName,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      child: Text(
                    "Check",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )),
                  SizedBox(
                    width: 10.0,
                  ),
                  Container(
                      child: Icon(
                    Icons.map_outlined,
                    color: Colors.white,
                  )),
                  SizedBox(
                    width: 10.0,
                  ),
                  Container(
                      child: Text(
                    "Locations",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )),
                ],
              )),
            ],
          )
        ],
      ),
    ),
  );
}

Fournisseur f1 = Fournisseur("SBS Informatique", "ville", [
  Boutique(
      lat: 34.056340,
      long: -118.232050,
      telephone: "+216 99 999 999",
      adresse: "Hello world my name is Mohamed")
]);
Fournisseur f2 = Fournisseur("SBS Informatique", "ville", [
  Boutique(
      lat: 34.056340,
      long: -118.232050,
      telephone: "+216 99 999 999",
      adresse: "Hello world my name is Mohamed")
]);
List<Fournisseur> fournisseurs = [f1, f2];
