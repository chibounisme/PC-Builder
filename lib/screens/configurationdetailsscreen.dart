import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_it/get_it.dart';
import 'package:pcbuilder/models/equipment.dart';
import 'package:pcbuilder/screens/ordernowscreen.dart';
import 'package:pcbuilder/screens/pickcase.dart';
import 'package:pcbuilder/utils/currencies.dart';
import 'package:pcbuilder/utils/utils.dart';

// ignore: must_be_immutable
class ConfigurationDetailsScreen extends StatefulWidget {
  dynamic configuration;
  ConfigurationDetailsScreen(dynamic configuration) {
    this.configuration = configuration;
  }

  @override
  _ConfigurationDetailsScreenState createState() =>
      _ConfigurationDetailsScreenState();
}

class _ConfigurationDetailsScreenState
    extends State<ConfigurationDetailsScreen> {
  Equipment cpu, graphicsCard, ram, psu, hcase, motherBoard, ssd;
  double pricetot = 0;

  Future<dynamic> _getEquipment(String id) async {
    DocumentSnapshot qs =
        await FirebaseFirestore.instance.collection('equipments').doc(id).get();
    return Equipment(
      id: qs.id,
      name: qs.data()['name'],
      description: qs.data()['description'],
      type: qs.data()['type'],
      imgUrl: qs.data()['img_url'],
      price: qs.data()['price'].toDouble(),
      brand: qs.data()['brand'],
    );
  }

  @override
  void initState() {
    _getEquipment(widget.configuration['cpu']).then((eq) {
      setState(() {
        cpu = eq;
        pricetot += cpu.price;
      });
    });
    _getEquipment(widget.configuration['graphics_card']).then((eq) {
      setState(() {
        graphicsCard = eq;
        pricetot += graphicsCard.price;
      });
    });
    _getEquipment(widget.configuration['ram']).then((eq) {
      setState(() {
        ram = eq;
        pricetot += ram.price;
      });
    });
    _getEquipment(widget.configuration['ssd']).then((eq) {
      setState(() {
        ssd = eq;
        pricetot += ssd.price;
      });
    });
    _getEquipment(widget.configuration['motherboard']).then((eq) {
      setState(() {
        motherBoard = eq;
        pricetot += motherBoard.price;
      });
    });
    _getEquipment(widget.configuration['case']).then((eq) {
      setState(() {
        hcase = eq;
        pricetot += hcase.price;
      });
    });
    _getEquipment(widget.configuration['psu']).then((eq) {
      setState(() {
        psu = eq;
        pricetot += psu.price;
      });
    });
    super.initState();
  }

  navigateToDetail1(Equipment equipment) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => DetailPage1(equipment)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.configuration['title']),
          centerTitle: true,
          backgroundColor: Colors.pink,
          elevation: 20,
        ),
        body: cpu != null &&
                graphicsCard != null &&
                ram != null &&
                psu != null &&
                motherBoard != null &&
                ssd != null &&
                hcase != null
            ? ListView(
                children: [
                  widget.configuration['description'] != null
                      ? ListTile(
                          title: Text("Description:"),
                          subtitle: Text(widget.configuration['description'],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                              softWrap: true,
                              style: TextStyle(fontSize: 15.0)),
                        )
                      : Container(),
                  ListTile(
                    title: Text(graphicsCard.name),
                    subtitle: Text((graphicsCard.price *
                                GetIt.instance<Currencies>()
                                    .currentConversionRate)
                            .toStringAsFixed(3) +
                        ' ' +
                        GetIt.instance<Currencies>().currentCurrency),
                    trailing: Icon(Icons.arrow_forward_sharp,
                        color: Colors.pink, size: 24.0),
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
                    subtitle: Text((cpu.price *
                                GetIt.instance<Currencies>()
                                    .currentConversionRate)
                            .toStringAsFixed(3) +
                        ' ' +
                        GetIt.instance<Currencies>().currentCurrency),
                    trailing: Icon(Icons.arrow_forward_sharp,
                        color: Colors.pink, size: 24.0),
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
                                GetIt.instance<Currencies>()
                                    .currentConversionRate)
                            .toStringAsFixed(3) +
                        ' ' +
                        GetIt.instance<Currencies>().currentCurrency),
                    trailing: Icon(Icons.arrow_forward_sharp,
                        color: Colors.pink, size: 24.0),
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
                    subtitle: Text((ram.price *
                                GetIt.instance<Currencies>()
                                    .currentConversionRate)
                            .toStringAsFixed(3) +
                        ' ' +
                        GetIt.instance<Currencies>().currentCurrency),
                    trailing: Icon(Icons.arrow_forward_sharp,
                        color: Colors.pink, size: 24.0),
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
                    subtitle: Text((ssd.price *
                                GetIt.instance<Currencies>()
                                    .currentConversionRate)
                            .toStringAsFixed(3) +
                        ' ' +
                        GetIt.instance<Currencies>().currentCurrency),
                    trailing: Icon(Icons.arrow_forward_sharp,
                        color: Colors.pink, size: 24.0),
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
                    subtitle: Text((psu.price *
                                GetIt.instance<Currencies>()
                                    .currentConversionRate)
                            .toStringAsFixed(3) +
                        ' ' +
                        GetIt.instance<Currencies>().currentCurrency),
                    trailing: Icon(Icons.arrow_forward_sharp,
                        color: Colors.pink, size: 24.0),
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
                                GetIt.instance<Currencies>()
                                    .currentConversionRate)
                            .toStringAsFixed(3) +
                        ' ' +
                        GetIt.instance<Currencies>().currentCurrency),
                    trailing: Icon(Icons.arrow_forward_sharp,
                        color: Colors.pink, size: 24.0),
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
                                    GetIt.instance<Currencies>()
                                        .currentConversionRate)
                                .toStringAsFixed(3) +
                            ' ' +
                            GetIt.instance<Currencies>().currentCurrency,
                        style:
                            TextStyle(color: Color(0xFFBFE2851), fontSize: 16),
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
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
              )
            : Container(
                child: Center(
                child: SpinKitFadingCircle(
                  color: Colors.pink,
                  size: 50.0,
                ),
              )));
  }
}
