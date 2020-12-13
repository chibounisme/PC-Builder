/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PickGraphicCardScreen extends StatefulWidget {
  @override
  _PickGraphicCardScreenState createState() => _PickGraphicCardScreenState();
}

class _PickGraphicCardScreenState extends State<PickGraphicCardScreen> {
  Future<List<Equipment>> equipments = remplissagelist();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick your Graphic Card!'),
      ),
      body: ListView.builder(
        itemCount: equipments.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(equipments[index].name),
            leading: Container(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(equipments[index].imgUrl),
                  ),
                  SizedBox(width: 15),
                ],
              ),
            ),
            children: <Widget>[
              Image.network(
                equipments[index].imgUrl,
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
              ListTile(
                title: Text("Description"),
              ),
            ],
          );
        },
      ),
    );
  }
}

class Equipment {
  String img_url;
  double price;
  String name;
  String description;
  String type;
  String brand;

  Equipment(
      {this.img_url,
      this.price,
      this.name,
      this.description,
      this.type,
      this.brand});

  @override
  String toString() {
    return "$name -- $type -- $price";
  }
}
*/
//Future<List<Equipment>> remplissagelist() async {
// List<Equipment> equipments = [];
//QuerySnapshot qs = await FirebaseFirestore.instance
//  .collection('equipments')
// .where("type", isEqualTo: "graphics_card")
// .get();
//qs.docs.forEach((element) {
//equipments.add(Equipment(
// name: element.data()['name'],
//description: element.data()['description'],
// type: element.data()['type'],
//img_url: element.data()['img_url'],
//price: element.data()['price'].toDouble(),
// brand: element.data()['brand'],
//));
//});
//equipments.forEach((element) {
//equipments.add(element);
//});
//return equipments;
//}
