import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pcbuilder/models/configuration.dart';
import 'package:pcbuilder/models/equipment.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pcbuilder/screens/pickcase.dart';

final getIt = GetIt.instance;

class ConfirmSetup extends StatefulWidget {
  @override
  _ConfirmSetupState createState() => _ConfirmSetupState();
}

class _ConfirmSetupState extends State<ConfirmSetup> {
  navigateToDetail(Equipment equipment) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => DetailPage(equipment)));
  }

  @override
  Widget build(BuildContext context) {
    Equipment graphicsCard = getIt<Configuration>().graphicsCard;
    return Scaffold(
      appBar: AppBar(
        title: Text("Final SetUp"),
        backgroundColor: Colors.pink,
      ),
      backgroundColor: Color(0xFF000000),
      body: ListView(
        children: [
          ListTile(
            title: Text(graphicsCard.name),
            subtitle: Text((graphicsCard.price.toString()) + 'Dt'),
            trailing:
                Icon(Icons.arrow_forward_sharp, color: Colors.pink, size: 24.0),
            leading: Container(
              width: MediaQuery.of(context).size.width * 0.19,
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(graphicsCard.imgUrl),
                  ),
                  SizedBox(width: 25),
                ],
              ),
            ),
            onTap: () => navigateToDetail(graphicsCard),
          )
        ],
      ),
    );
  }
}
