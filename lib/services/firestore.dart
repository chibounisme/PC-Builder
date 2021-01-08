import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:pcbuilder/models/equipment.dart';

class FireStoreService extends ChangeNotifier {
  FireStoreService();

  static Future<dynamic> getEquipmentsByType(String equipmentType) async {
    QuerySnapshot qs = await FirebaseFirestore.instance
        .collection('equipments')
        .where("type", isEqualTo: equipmentType)
        .get();
    return qs.docs
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
}
