import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pcbuilder/models/configuration.dart';
import 'package:pcbuilder/models/equipment.dart';
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

  navigateToDetail1(Equipment equipment) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => DetailPage1(equipment)));
  }

  // navigateToDetail12(Equipment equipment) {
  // Navigator.push(context,
  //   MaterialPageRoute(builder: (context) => DetailPage(equipment)));
  @override
  Widget build(BuildContext context) {
    Equipment graphicsCard = getIt<Configuration>().graphicsCard;
    Equipment cpu = getIt<Configuration>().cpu;
    Equipment motherBoard = getIt<Configuration>().motherboard;
    Equipment ram = getIt<Configuration>().ram;
    Equipment ssd = getIt<Configuration>().ssd;
    Equipment psu = getIt<Configuration>().psu;
    Equipment hcase = getIt<Configuration>().hcase;
    return Scaffold(
      appBar: AppBar(
        title: Text("Final SetUp"),
        backgroundColor: Colors.pink,
        elevation: 20,
      ),
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
          ),
          ListTile(
            title: Text(cpu.name),
            subtitle: Text((cpu.price.toString()) + 'Dt'),
            trailing:
                Icon(Icons.arrow_forward_sharp, color: Colors.pink, size: 24.0),
            leading: Container(
              width: MediaQuery.of(context).size.width * 0.19,
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(cpu.imgUrl),
                  ),
                  SizedBox(width: 25),
                ],
              ),
            ),
            onTap: () => navigateToDetail(cpu),
          ),
          ListTile(
            title: Text(motherBoard.name),
            subtitle: Text((motherBoard.price.toString()) + 'Dt'),
            trailing:
                Icon(Icons.arrow_forward_sharp, color: Colors.pink, size: 24.0),
            leading: Container(
              width: MediaQuery.of(context).size.width * 0.19,
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(motherBoard.imgUrl),
                  ),
                  SizedBox(width: 25),
                ],
              ),
            ),
            onTap: () => navigateToDetail(motherBoard),
          ),
          ListTile(
            title: Text(ram.name),
            subtitle: Text((ram.price.toString()) + 'Dt'),
            trailing:
                Icon(Icons.arrow_forward_sharp, color: Colors.pink, size: 24.0),
            leading: Container(
              width: MediaQuery.of(context).size.width * 0.19,
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(ram.imgUrl),
                  ),
                  SizedBox(width: 25),
                ],
              ),
            ),
            onTap: () => navigateToDetail(ram),
          ),
          ListTile(
            title: Text(ssd.name),
            subtitle: Text((ssd.price.toString()) + 'Dt'),
            trailing:
                Icon(Icons.arrow_forward_sharp, color: Colors.pink, size: 24.0),
            leading: Container(
              width: MediaQuery.of(context).size.width * 0.19,
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(ssd.imgUrl),
                  ),
                  SizedBox(width: 25),
                ],
              ),
            ),
            onTap: () => navigateToDetail(ssd),
          ),
          ListTile(
            title: Text(psu.name),
            subtitle: Text((psu.price.toString()) + 'Dt'),
            trailing:
                Icon(Icons.arrow_forward_sharp, color: Colors.pink, size: 24.0),
            leading: Container(
              width: MediaQuery.of(context).size.width * 0.19,
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(psu.imgUrl),
                  ),
                  SizedBox(width: 25),
                ],
              ),
            ),
            onTap: () => navigateToDetail(psu),
          ),
          ListTile(
            title: Text(hcase.name),
            subtitle: Text((hcase.price.toString()) + 'Dt'),
            trailing:
                Icon(Icons.arrow_forward_sharp, color: Colors.pink, size: 24.0),
            leading: Container(
              width: MediaQuery.of(context).size.width * 0.19,
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(hcase.imgUrl),
                  ),
                  SizedBox(width: 25),
                ],
              ),
            ),
            onTap: () => navigateToDetail1(hcase),
          )
        ],
      ),
    );
  }
}
