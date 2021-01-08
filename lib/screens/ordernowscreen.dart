import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pcbuilder/screens/loginscreen.dart';
import 'package:pcbuilder/utils/utils.dart';

class OrderNow extends StatefulWidget {
  @override
  _OrderNowState createState() => _OrderNowState();
}

class _OrderNowState extends State<OrderNow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text("Order Now!"),
        backgroundColor: Colors.pink,
        elevation: 20,
      ),
      body: GridView.count(
        crossAxisCount: 1,
        padding: EdgeInsets.all(16.0),
        childAspectRatio: 3.0,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        children: <Widget>[
          myGridItems(
              "SBS Informatique",
              "https://www.keejob.com/media/recruiter/recruiter_21846/logo-21846-20201026-174656.png",
              0xffF4E4BA,
              0xffF4E4BA),
          myGridItems(
              "MEGA PC",
              "https://megapc.tn/assets/images/icon/logo.png",
              0xff000000,
              0xff000000),
          myGridItems(
              "WIKI",
              "https://www.keejob.com/media/recruiter/recruiter_12899/logo-12899-20170421-165921.png",
              0xff000000,
              0xff000000),
          myGridItems(
              "MyTeck",
              "https://cdn.discordapp.com/attachments/786675454303535124/797127009989558333/avatar-removebg-preview.png",
              0xff000000,
              0xff000000),
        ],
      ),
    );
  }
}

Widget myGridItems(String gridName, String gridimage, int color1, int color2) {
  return RaisedButton(
    onPressed: () {
      debugPrint("clicked it");
    },
    padding: EdgeInsets.symmetric(),
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          gradient: new LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment(1.0, 1.0),
            colors: [
              Color(color1),
              Color(color2),
            ],
          )),
      child: Stack(
        children: <Widget>[
          Opacity(
            opacity: 0.9,
            child: Container(
              decoration: new BoxDecoration(
                  borderRadius: BorderRadius.circular(24.0),
                  image: DecorationImage(
                    image: new NetworkImage(gridimage),
                    fit: BoxFit.fill,
                  )),
            ),
          ),
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //     Padding(
          //       padding: const EdgeInsets.only(left: 16.0),
          //       child: Text(
          //         gridName,
          //         style: TextStyle(
          //             color: Colors.white,
          //             fontSize: 20,
          //             fontWeight: FontWeight.bold),
          //       ),
          //     ),
          //     Container(
          //         child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: <Widget>[
          //         Container(
          //             child: Text(
          //           "Check",
          //           style: TextStyle(color: Colors.white, fontSize: 16),
          //         )),
          //         SizedBox(
          //           width: 10.0,
          //         ),
          //         Container(
          //             child: Icon(
          //           Icons.map_outlined,
          //           color: Colors.white,
          //         )),
          //         SizedBox(
          //           width: 10.0,
          //         ),
          //         Container(
          //             child: Text(
          //           "Locations",
          //           style: TextStyle(color: Colors.white, fontSize: 16),
          //         )),
          //       ],
          //     )),
          //     SizedBox(
          //       height: 10.0,
          //     )
          //   ],
          // )
        ],
      ),
    ),
  );
}
