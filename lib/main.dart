import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:pcbuilder/screens/loginscreen.dart';
import 'package:pcbuilder/services/auth.dart';
import 'package:pcbuilder/utils/utils.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // allows to pass user information down the widget tree
    return StreamProvider.value(
      value: AuthService().user,
      // allows to hide keyboard quickly
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                inputDecorationTheme: InputDecorationTheme(
                    hintStyle: TextStyle(color: Colors.white)),
                fontFamily: "Nunito"),
            home: Scaffold(
              body: Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/images/background.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: WelcomeScreen(),
              ),
            )),
      ),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              moveToPage(context, LoginScreen(), 1);
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
    );
  }
}
