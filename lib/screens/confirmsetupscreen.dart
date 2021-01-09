import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pcbuilder/models/configuration.dart';
import 'package:pcbuilder/models/equipment.dart';
import 'package:pcbuilder/screens/ordernowscreen.dart';
import 'package:pcbuilder/screens/pickcase.dart';
import 'package:pcbuilder/screens/saveconfig.dart';
import 'package:pcbuilder/utils/currencies.dart';
import 'package:pcbuilder/utils/utils.dart';

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
    double pricetot = graphicsCard.price +
        cpu.price +
        motherBoard.price +
        ram.price +
        ssd.price +
        psu.price +
        hcase.price;
    return Scaffold(
      appBar: AppBar(
        title: Text("Final Setup"),
        backgroundColor: Colors.pink,
        elevation: 20,
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(graphicsCard.name),
            subtitle: Text((graphicsCard.price *
                        GetIt.instance<Currencies>().currentConversionRate)
                    .toStringAsFixed(3) +
                ' ' +
                GetIt.instance<Currencies>().currentCurrency),
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
            onTap: () => navigateToDetail1(graphicsCard),
          ),
          ListTile(
            title: Text(cpu.name),
            subtitle: Text(
                (cpu.price * GetIt.instance<Currencies>().currentConversionRate)
                        .toStringAsFixed(3) +
                    ' ' +
                    GetIt.instance<Currencies>().currentCurrency),
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
            onTap: () => navigateToDetail1(cpu),
          ),
          ListTile(
            title: Text(motherBoard.name),
            subtitle: Text((motherBoard.price *
                        GetIt.instance<Currencies>().currentConversionRate)
                    .toStringAsFixed(3) +
                ' ' +
                GetIt.instance<Currencies>().currentCurrency),
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
            onTap: () => navigateToDetail1(motherBoard),
          ),
          ListTile(
            title: Text(ram.name),
            subtitle: Text(
                (ram.price * GetIt.instance<Currencies>().currentConversionRate)
                        .toStringAsFixed(3) +
                    ' ' +
                    GetIt.instance<Currencies>().currentCurrency),
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
            onTap: () => navigateToDetail1(ram),
          ),
          ListTile(
            title: Text(ssd.name),
            subtitle: Text(
                (ssd.price * GetIt.instance<Currencies>().currentConversionRate)
                        .toStringAsFixed(3) +
                    ' ' +
                    GetIt.instance<Currencies>().currentCurrency),
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
            onTap: () => navigateToDetail1(ssd),
          ),
          ListTile(
            title: Text(psu.name),
            subtitle: Text(
                (psu.price * GetIt.instance<Currencies>().currentConversionRate)
                        .toStringAsFixed(3) +
                    ' ' +
                    GetIt.instance<Currencies>().currentCurrency),
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
            onTap: () => navigateToDetail1(psu),
          ),
          ListTile(
            title: Text(hcase.name),
            subtitle: Text((hcase.price *
                        GetIt.instance<Currencies>().currentConversionRate)
                    .toStringAsFixed(3) +
                ' ' +
                GetIt.instance<Currencies>().currentCurrency),
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
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 0),
                borderRadius: BorderRadius.circular(50)),
            padding: EdgeInsets.all(20),
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 0),
                borderRadius: BorderRadius.circular(50)),
            padding: EdgeInsets.symmetric(),
            height: 60,
            child: Center(
              child: Text(
                "Total = " +
                    (pricetot *
                            GetIt.instance<Currencies>().currentConversionRate)
                        .toStringAsFixed(3) +
                    ' ' +
                    GetIt.instance<Currencies>().currentCurrency,
                style: TextStyle(color: Color(0xFFBFE2851), fontSize: 16),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 0),
                borderRadius: BorderRadius.circular(50)),
            padding: EdgeInsets.all(20),
            height: 20,
          ),
          Container(
            child: GestureDetector(
              onTap: () {
                moveToPage(context, SaveConfig());
              },
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFBFE2851),
                      borderRadius: BorderRadius.circular(50)),
                  padding: EdgeInsets.all(10),
                  height: 40,
                  width: 175,
                  child: Center(
                    child: Text(
                      "Save Configuration",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 0),
                borderRadius: BorderRadius.circular(50)),
            padding: EdgeInsets.all(10),
            height: 20,
          ),
          Container(
            child: GestureDetector(
              onTap: () {
                moveToPage(context, OrderNow());
              },
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFBFE2851),
                      borderRadius: BorderRadius.circular(50)),
                  padding: EdgeInsets.all(10),
                  height: 40,
                  width: 175,
                  child: Center(
                    child: Text(
                      "Order Now!",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 0),
                borderRadius: BorderRadius.circular(50)),
            padding: EdgeInsets.all(10),
            height: 20,
          ),
        ],
      ),
    );
  }
}
