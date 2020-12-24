import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';

// Color Variables
Color color_1 = Color(0xFFBC7C7C7);
Color color_2 = Color(0xFFBB9B9B9);
Color color_3 = Color(0xFFBFE2851);

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: 50.0,
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/pro.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Stack(
            children: <Widget>[
              Container(
                  child: Row(children: [
                    IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        })
                  ])),
              Align(
                alignment: Alignment(0, -0.5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(height: 10),
                    CircleAvatar(
                      radius: 90.0,
                      backgroundImage: new AssetImage('images/hackfest.jpg'),
                      backgroundColor: Colors.grey,
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      "Bsk Sahar",
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                      ),
                    ),
                    Container(height: 10),
                    Text(
                      "Developer",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.pink,
                      ),
                    ),
                    Container(height: 10),
                    Text(
                      "sahar.boussoukaya@supcom.tn",
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.white,
                      ),
                    ),
                    Container(height: 30),
                    new SizedBox (
                      width : 300.0,
                      height: 50.0,
                      child: new RaisedButton(
                      color: Colors.pink,
                      onPressed: () {},
                      child: Text(
                        'check your settings  ',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ),
                    Container(height: 30),
                    new SizedBox (
                      width : 300.0,
                      height: 50.0,
                      child: new RaisedButton(
                        color: Colors.pink,
                        onPressed: () {},
                        child: Text(
                          'create a new setting',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Container(height: 30),
                    new SizedBox (
                      width : 300.0,
                      height: 50.0,
                      child: new RaisedButton(
                        color: Colors.pink,
                        onPressed: () {},
                        child: Text(
                          'update your profile page',
                          style: TextStyle(color: Colors.white),
                        ),

                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
