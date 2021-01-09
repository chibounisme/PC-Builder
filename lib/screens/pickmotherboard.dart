import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pcbuilder/models/equipment.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pcbuilder/screens/pickram.dart';
import 'package:pcbuilder/services/firestore.dart';
import 'package:pcbuilder/utils/currencies.dart';
import 'package:pcbuilder/utils/utils.dart';
import 'package:pcbuilder/models/configuration.dart';
import 'package:get_it/get_it.dart';
import 'package:pcbuilder/screens/homescreen.dart';

class PickMotherBoard extends StatefulWidget {
  @override
  _PickMotherBoardState createState() => _PickMotherBoardState();
}

class _PickMotherBoardState extends State<PickMotherBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pick a Motherboard"),
        backgroundColor: Colors.pink,
        elevation: 20,
        actions: [
          IconButton(
              icon: Icon(Icons.home_filled),
              onPressed: () => {moveToPage(context, HomeScreen())})
        ],
      ),
      backgroundColor: Color(0xFF000000),
      body: ListPage(),
    );
  }
}

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<Equipment> _equipments = [];
  List<Equipment> _displayedEquipments = [];

  @override
  initState() {
    FireStoreService.getEquipmentsByType('motherboard').then((l) {
      setState(() {
        _equipments = l;
        _displayedEquipments = _equipments;
      });
    });
    super.initState();
  }

  navigateToDetail(Equipment equipment) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => DetailPage(equipment)));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        TextEditingController().clear();
      },
      child: Material(
          child: _equipments.length == 0
              ? Center(
                  child: SpinKitCubeGrid(
                    color: Colors.pink,
                    size: 50.0,
                  ),
                )
              : ListView.builder(
                  itemCount: _displayedEquipments.length + 1,
                  itemBuilder: (_, index) {
                    return index == 0 ? _searchBar() : _listItem(index - 1);
                  })),
    );
  }

  _searchBar() {
    return Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
              cursorColor: Colors.pink,
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.grey[500]),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.pink),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.pink),
                ),
              ),
              onChanged: (text) {
                final searchString =
                    text.replaceAll(RegExp('/\W/g'), '').toLowerCase();
                setState(() {
                  _displayedEquipments = _equipments.where((element) {
                    return element.name.toLowerCase().contains(searchString) ||
                        element.description
                            .toLowerCase()
                            .contains(searchString);
                  }).toList();
                });
              },
            ),
            if (_displayedEquipments.length == 0) ...[
              Center(
                  child: Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('No results were found :(')))
            ]
          ],
        ));
  }

  _listItem(index) {
    return ListTile(
      title: Text(_displayedEquipments[index].name),
      subtitle: Text((_displayedEquipments[index].price *
                  GetIt.instance<Currencies>().currentConversionRate)
              .toStringAsFixed(3) +
          ' ' +
          GetIt.instance<Currencies>().currentCurrency),
      trailing: Icon(Icons.arrow_forward_sharp, color: Colors.pink, size: 24.0),
      leading: Container(
        width: MediaQuery.of(context).size.width * 0.19,
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(_displayedEquipments[index].imgUrl),
            ),
            SizedBox(width: 25),
          ],
        ),
      ),
      onTap: () => navigateToDetail(_displayedEquipments[index]),
    );
  }
}

class DetailPage extends StatefulWidget {
  final Equipment equipements;

  DetailPage(this.equipements);
  Equipment get equipment => equipements;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.equipements.name),
        backgroundColor: Colors.pink,
        elevation: 20,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            Image.network(widget.equipements.imgUrl),
            ListTile(
              title: Text((widget.equipements.price *
                          GetIt.instance<Currencies>().currentConversionRate)
                      .toStringAsFixed(3) +
                  ' ' +
                  GetIt.instance<Currencies>().currentCurrency),
              subtitle: Text(widget.equipements.description),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: GestureDetector(
                onTap: () {
                  //sauvgarder element
                  getIt<Configuration>().motherboard = widget.equipment;
                  moveToPage(context, PickRam());
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFBFE2851), width: 2),
                      borderRadius: BorderRadius.circular(50)),
                  padding: EdgeInsets.all(10),
                  width: 120,
                  child: Center(
                    child: Text(
                      "I Want It !",
                      style: TextStyle(color: Color(0xFFBFE2851), fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            )
          ]),
        ),
      ),
    );
  }
}
