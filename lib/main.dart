import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:pcbuilder/screens/welcomescreen.dart';
import 'package:pcbuilder/services/auth.dart';
import 'package:provider/provider.dart';
//hedha ketbou mootez
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
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              inputDecorationTheme: InputDecorationTheme(
                  hintStyle: TextStyle(color: Colors.white)),
              fontFamily: "Nunito"),
          home: WelcomeScreen(),
        ));
  }
}
