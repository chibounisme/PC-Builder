import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
  Future getPosts() async {
    var firestore = FirebaseFirestore.instance;

    QuerySnapshot qn= await firestore.collection("equipments").get();
    print("hani hne");
    print(qn.docs);
    return qn.docs;
  }
  @override
  Widget build(BuildContext context) {
    return Container(

      child: FutureBuilder( future: getPosts(),
        builder: (_, snapshot){

        if(snapshot.connectionState==ConnectionState.waiting)
        {
          return Center(
            child: Text("loading..."),
          );
        }
        else{
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (_, index){
                return ListTile(
                  title: Text(snapshot.data[index].data['equipments']),
                );


          });


        }

      },),
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


