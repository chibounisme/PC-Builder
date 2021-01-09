import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfile extends StatefulWidget {
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  String _imageUrl;
  String _name;
  bool nameChangeLoading = false;
  bool imageChangeLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _uploadImage(PickedFile file) async {
    File im = File(file.path);
    String fileName = DateTime.now().toString();
    await FirebaseStorage.instance
        .ref()
        .child('images/$fileName.jpg')
        .putFile(im);
    final downloadUrl = await FirebaseStorage.instance
        .ref()
        .child('images/$fileName.jpg')
        .getDownloadURL();
    print('Download url is: $downloadUrl');
    final user = Provider.of<User>(context, listen: false);
    await FirebaseFirestore.instance
        .collection('profile')
        .doc(user.uid)
        .update({'photo': downloadUrl});
    setState(() {
      _imageUrl = downloadUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<User>(context);

    return Material(
      child: Container(
        height: 50.0,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/profile.png"),
              fit: BoxFit.fill,
            )),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('profile')
                  .doc(data.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: SpinKitFadingCircle(
                      color: Colors.white,
                      size: 50.0,
                    ),
                  );
                }
                var userDocument = snapshot.data;
                _imageUrl = userDocument["photo"];
                return Stack(
                  children: <Widget>[
                    Container(
                        child: Row(children: [
                      IconButton(
                          icon: Icon(Icons.arrow_back),
                          color: Colors.pink,
                          onPressed: () {
                            Navigator.pop(context);
                          })
                    ])),
                    Align(
                      alignment: Alignment(0, -0.5),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Center(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 90.0,
                                  backgroundImage: new NetworkImage(_imageUrl),
                                  backgroundColor: Colors.grey,
                                ),
                                IconButton(
                                    iconSize: 50,
                                    icon: Icon(Icons.edit),
                                    color: Color(0xFFBFE2851),
                                    onPressed: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return StatefulBuilder(builder:
                                                (BuildContext context,
                                                    StateSetter setState) {
                                              return Container(
                                                height: 150,
                                                child: imageChangeLoading ==
                                                        true
                                                    ? Center(
                                                        child: ListView(
                                                          shrinkWrap: true,
                                                          children: [
                                                            SpinKitDualRing(
                                                                color:
                                                                    Colors.pink,
                                                                size: 32),
                                                            Center(
                                                              child: Text(
                                                                  'Uploading image...'),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    : Column(
                                                        children: [
                                                          ListTile(
                                                              leading: Icon(
                                                                  Icons.camera),
                                                              title: Text(
                                                                  'Take a photo'),
                                                              onTap: () async {
                                                                // take image from the camera
                                                                PickedFile
                                                                    file =
                                                                    await ImagePicker()
                                                                        .getImage(
                                                                            source:
                                                                                ImageSource.camera);
                                                                if (file !=
                                                                    null) {
                                                                  setState(() {
                                                                    imageChangeLoading =
                                                                        true;
                                                                  });
                                                                  await _uploadImage(
                                                                      file);
                                                                  setState(() {
                                                                    imageChangeLoading =
                                                                        false;
                                                                  });
                                                                  Navigator.pop(
                                                                      context);
                                                                  Fluttertoast.showToast(
                                                                      msg:
                                                                          "Changed picture successfully!",
                                                                      toastLength:
                                                                          Toast
                                                                              .LENGTH_SHORT,
                                                                      gravity: ToastGravity
                                                                          .BOTTOM,
                                                                      timeInSecForIosWeb:
                                                                          3,
                                                                      backgroundColor:
                                                                          Color(
                                                                              0xFFBFE2851),
                                                                      textColor:
                                                                          Colors
                                                                              .white,
                                                                      fontSize:
                                                                          16.0);
                                                                }
                                                              }),
                                                          ListTile(
                                                              leading: Icon(
                                                                  Icons.image),
                                                              title: Text(
                                                                  'Select a photo from Gallery'),
                                                              onTap: () async {
                                                                // select a photo from the gallery
                                                                PickedFile
                                                                    file =
                                                                    await ImagePicker()
                                                                        .getImage(
                                                                            source:
                                                                                ImageSource.gallery);
                                                                if (file !=
                                                                    null) {
                                                                  setState(() {
                                                                    imageChangeLoading =
                                                                        true;
                                                                    print(
                                                                        imageChangeLoading);
                                                                  });
                                                                  await _uploadImage(
                                                                      file);
                                                                  print('yes!');
                                                                  setState(() {
                                                                    imageChangeLoading =
                                                                        false;
                                                                    print(
                                                                        imageChangeLoading);
                                                                  });
                                                                  Navigator.pop(
                                                                      context);
                                                                  Fluttertoast.showToast(
                                                                      msg:
                                                                          "Changed picture successfully!",
                                                                      toastLength:
                                                                          Toast
                                                                              .LENGTH_SHORT,
                                                                      gravity: ToastGravity
                                                                          .BOTTOM,
                                                                      timeInSecForIosWeb:
                                                                          3,
                                                                      backgroundColor:
                                                                          Color(
                                                                              0xFFBFE2851),
                                                                      textColor:
                                                                          Colors
                                                                              .white,
                                                                      fontSize:
                                                                          16.0);
                                                                }
                                                              }),
                                                        ],
                                                      ),
                                              );
                                            });
                                          });
                                    }),
                              ],
                            ),
                          ),
                          Container(height: 30),
                          new SizedBox(
                            width: 200.0,
                            height: 50.0,
                          ),
                          SizedBox(height: 4.0),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xFFBC7C7C7), width: 2),
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              children: <Widget>[
                                Container(
                                    width: 60,
                                    child: Icon(
                                      Icons.account_box_sharp,
                                      size: 20,
                                      color: Colors.white,
                                    )),
                                Form(
                                  key: _formKey,
                                  child: Expanded(
                                    child: TextFormField(
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.white),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 20),
                                          border: InputBorder.none,
                                          hintText: "Enter your new name"),
                                      onChanged: (value) {
                                        _name = value;
                                      },
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter a valid name';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(height: 60),
                          Container(
                            child: GestureDetector(
                              onTap: () async {
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    nameChangeLoading = true;
                                  });
                                  final user =
                                      Provider.of<User>(context, listen: false);
                                  await FirebaseFirestore.instance
                                      .collection('profile')
                                      .doc(user.uid)
                                      .update({'name': _name});
                                  setState(() {
                                    nameChangeLoading = false;
                                  });
                                  Fluttertoast.showToast(
                                      msg: "Changed name successfully!",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 5,
                                      backgroundColor: Color(0xFFBFE2851),
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
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
                                    child: nameChangeLoading
                                        ? SpinKitDualRing(
                                            color: Colors.black, size: 22)
                                        : Text(
                                            "Save new name",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
