import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

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
                          Text(
                            userDocument["name"],
                            style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.white,
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
