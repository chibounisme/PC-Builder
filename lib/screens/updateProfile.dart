import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'package:fluttertoast/fluttertoast.dart';

class updateProfile extends StatefulWidget {
  @override
  _updateProfileState createState() => _updateProfileState();
}

class _updateProfileState extends State<updateProfile> {
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<User>(context);
    print(data.uid);
    return Material(
      child: Container(
        height: 50.0,
        decoration: new BoxDecoration(color: Colors.grey[900]),
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
                print("les données sont $userDocument");
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
                          IconButton(
                              icon: Icon(Icons.edit),
                              color: Colors.grey,
                              onPressed: () {}),
                          Container(height: 10),
                          CircleAvatar(
                            radius: 90.0,
                            backgroundImage:
                                new NetworkImage(userDocument["photo"]),
                            backgroundColor: Colors.grey,
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
                                Expanded(
                                  child: TextFormField(
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.white),
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 20),
                                        border: InputBorder.none,
                                        hintText:
                                            "Enter your new name"),
                                    onChanged: (value) {

                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter a valid title';
                                      }
                                      return null;
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                Container(height: 60),
                          Container(
                            child: GestureDetector(
                              onTap: () {},
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
                                      "Save",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
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
