import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pcbuilder/screens/loginscreen.dart';

void moveToPage(BuildContext context, Widget destinationWidget) {
  Route route = MaterialPageRoute(builder: (context) => destinationWidget);
  Navigator.push(context, route);
}

void logout(context) async {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (Route<dynamic> route) => false);
}
