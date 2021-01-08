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
              "https://d1fmx1rbmqrxrr.cloudfront.net/cnet/optim/i/edit/2019/04/eso1644bsmall__w770.jpg",
              0xff00FFFD,
              0xff00FFFD),
          myGridItems(
              "SBS Informatique",
              "https://d1fmx1rbmqrxrr.cloudfront.net/cnet/optim/i/edit/2019/04/eso1644bsmall__w770.jpg",
              0xffFFAC00,
              0xffFFAC00),
          myGridItems(
              "MEGA PC",
              "https://d1fmx1rbmqrxrr.cloudfront.net/cnet/optim/i/edit/2019/04/eso1644bsmall__w770.jpg",
              0xffFCFF00,
              0xffFCFF00),
          myGridItems(
              "WIKI",
              "https://d1fmx1rbmqrxrr.cloudfront.net/cnet/optim/i/edit/2019/04/eso1644bsmall__w770.jpg",
              0xff33E903,
              0xff33E903),
          myGridItems(
              "MyTeck",
              "https://d1fmx1rbmqrxrr.cloudfront.net/cnet/optim/i/edit/2019/04/eso1644bsmall__w770.jpg",
              0xffFF00FB,
              0xffFF00FB),
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
