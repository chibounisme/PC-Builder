import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pcbuilder/models/equipment.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pcbuilder/screens/confirmsetupscreen.dart';
import 'package:pcbuilder/utils/utils.dart';
import 'package:get_it/get_it.dart';
import 'package:pcbuilder/models/configuration.dart';
import 'package:pcbuilder/screens/homescreen.dart';

class PickCase extends StatefulWidget {
  @override
  _PickCaseState createState() => _PickCaseState();
}

class _PickCaseState extends State<PickCase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pick your Case"),
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
  Future<List<Equipment>> getPosts() async {
    var firestore = FirebaseFirestore.instance;
    //print("hani hne");
    QuerySnapshot qn = await firestore
        .collection("equipments")
        .where("type", isEqualTo: "case")
        .get();
    print(qn.docs);
    return qn.docs
        .map((element) => Equipment(
              id: element.id,
              name: element.data()['name'],
              description: element.data()['description'],
              type: element.data()['type'],
              imgUrl: element.data()['img_url'],
              price: element.data()['price'].toDouble(),
              brand: element.data()['brand'],
            ))
        .toList();
  }

  navigateToDetail(Equipment equipment) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => DetailPage(equipment)));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FutureBuilder(
        future: getPosts(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitSquareCircle(
                color: Colors.pink,
                size: 50.0,
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (_, index) {
                  return ListTile(
                    title: Text(snapshot.data[index].name),
                    subtitle:
                        Text((snapshot.data[index].price.toString()) + 'Dt'),
                    trailing: Icon(Icons.arrow_forward_sharp,
                        color: Colors.pink, size: 24.0),
                    leading: Container(
                      width: MediaQuery.of(context).size.width * 0.19,
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(snapshot.data[index].imgUrl),
                          ),
                          SizedBox(width: 25),
                        ],
                      ),
                    ),
                    onTap: () => navigateToDetail(snapshot.data[index]),
                  );
                });
          } else
            return Container();
        },
      ),
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
              title: Text(widget.equipements.price.toString() + "Dt"),
              subtitle: Text(widget.equipements.description),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: GestureDetector(
                onTap: () {
                  //sauvgarder element
                  getIt<Configuration>().hcase = widget.equipment;
                  moveToPage(context, ConfirmSetup());
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

class DetailPage1 extends StatefulWidget {
  final Equipment equipements;

  DetailPage1(this.equipements);
  Equipment get equipment => equipements;
  @override
  _DetailPage1State createState() => _DetailPage1State();
}

class _DetailPage1State extends State<DetailPage1> {
  @override
  Widget build(BuildContext context) {
    //final getIt = GetIt.instance;
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
              title: Text(widget.equipements.price.toString() + "Dt"),
              subtitle: Text(widget.equipements.description),
            ),
            SizedBox(
              height: 20,
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
