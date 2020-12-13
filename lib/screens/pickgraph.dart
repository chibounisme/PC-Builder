import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pcbuilder/models/equipment.dart';

class PickGraph extends StatefulWidget {
  @override
  _PickGraphState createState() => _PickGraphState();
}

class _PickGraphState extends State<PickGraph> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pick a Graphic Card"),
        backgroundColor: Colors.pink,
      ),
      backgroundColor: Colors.black,
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
        .where("type", isEqualTo: "graphics_card")
        .get();
    print(qn.docs);
    return qn.docs
        .map((element) => Equipment(
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
              child: Text("loading..."),
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
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.equipements.name),
        backgroundColor: Colors.pink,
      ),
      body: Container(
        child: Card(
          child: ListTile(
              //  title:,
              //subtitle: ,
              ),
        ),
      ),
    );
  }
}
