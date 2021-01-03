import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SaveConfig extends StatefulWidget {
  @override
  _SaveConfigState createState() => _SaveConfigState();
}

class _SaveConfigState extends State<SaveConfig> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Save your config"),
        backgroundColor: Colors.pink,
        elevation: 20,
      ),
    );
  }
}
