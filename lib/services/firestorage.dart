import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FireStorageService extends ChangeNotifier {
  FireStorageService();

  static Future<Widget> getImage(BuildContext context, String image) async {
    String url =
        await FirebaseStorage.instance.ref().child(image).getDownloadURL();
    return Image.network(
      url,
      fit: BoxFit.scaleDown,
    );
  }
}
