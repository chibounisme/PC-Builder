import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pcbuilder/models/equipment.dart';

class PickGraph extends StatefulWidget {
  @override
  _PickGraphState createState() => _PickGraphState();
}

class _PickGraphState extends State<PickGraph> {
  @override
  Widget build(BuildContext context) {
    return ListPage();
  }
}

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Future<List<Equipment>> getPosts() async {
    var firestore = FirebaseFirestore.instance;
    print("hani hne");
    QuerySnapshot qn = await firestore.collection("equipments").get();
    print(qn.docs);
    return qn.docs
        .map((element) => Equipment(
              name: element.data()['name'],
              description: element.data()['description'],
              type: element.data()['type'],
              img_url: element.data()['img_url'],
              price: element.data()['price'].toDouble(),
              brand: element.data()['brand'],
            ))
        .toList();
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
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
