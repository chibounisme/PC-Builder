import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pcbuilder/screens/configurationsscreen.dart';
import 'package:pcbuilder/screens/updateProfile.dart';
import 'package:pcbuilder/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

// Color Variables
Color color_1 = Color(0xFFBC7C7C7);
Color color_2 = Color(0xFFBB9B9B9);
Color color_3 = Color(0xFFBFE2851);

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<User>(context);
    print(data.uid);
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
                          Container(height: 10),
                          CircleAvatar(
                            radius: 90.0,
                            backgroundImage:
                                new NetworkImage(userDocument["photo"]),
                            backgroundColor: Colors.grey,
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            userDocument["name"],
                            style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.white,
                            ),
                          ),
                          Container(height: 10),
                          Text(
                            'Joined ${timeago.format(userDocument["date"].toDate())}',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.pink,
                            ),
                          ),
                          Container(height: 10),
                          Text(
                            data.email,
                            style: TextStyle(
                              fontSize: 10.0,
                              color: Colors.white,
                            ),
                          ),
                          Container(height: 60),
                          new SizedBox(
                            width: 300.0,
                            height: 50.0,
                            child: new RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.red)),
                              color: Colors.pink,
                              onPressed: () {
                                moveToPage(context, ConfigurationScreen());
                              },
                              child: Text(
                                'Check your configurations',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Container(height: 60),
                          new SizedBox(
                            width: 300.0,
                            height: 50.0,
                            child: new RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.red)),
                              color: Colors.pink,
                              onPressed: () {
                                moveToPage(context, UpdateProfile());
                              },
                              child: Text(
                                'Update your profile page',
                                style: TextStyle(color: Colors.white),
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
