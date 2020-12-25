import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pcbuilder/models/equipment.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



class ConfirmSetup extends StatefulWidget {
  @override
  _ConfirmSetupState createState() => _ConfirmSetupState();
}

class _ConfirmSetupState extends State<ConfirmSetup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text("Final SetUp"),
        backgroundColor: Colors.pink,
      ),
      backgroundColor: Color(0xFF000000),
      body:
    );
  
  }
}