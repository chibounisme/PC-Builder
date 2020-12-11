import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pcbuilder/screens/loginscreen.dart';
import 'package:pcbuilder/utils/utils.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    child: Text(
                      "WELCOME GAMERS!",
                      style: TextStyle(color: Color(0xFFBFE2851), fontSize: 28),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(32),
                    child: Text(
                      "Start building your dream PC now!",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFFBFE2851), fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Center(
                child: Image.asset("assets/images/logo_image.png", scale: 2),
              ),
            ),
            Container(
              child: GestureDetector(
                onTap: () {
                  moveToPage(context, LoginScreen());
                },
                child: Container(
                  margin: EdgeInsets.all(32),
                  padding: EdgeInsets.all(20),
                  // width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0xFFBFE2851),
                      borderRadius: BorderRadius.circular(50)),
                  child: Center(
                    child: Text('Get Started',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        )),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
