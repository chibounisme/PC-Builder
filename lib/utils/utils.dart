import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void moveToPage(BuildContext context, Widget destinationWidget) {
  Route route = MaterialPageRoute(builder: (context) => destinationWidget);
  Navigator.push(context, route);
}
