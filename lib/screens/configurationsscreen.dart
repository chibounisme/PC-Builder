import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pcbuilder/screens/configurationdetailsscreen.dart';
import 'package:pcbuilder/utils/utils.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:provider/provider.dart';

class ConfigurationScreen extends StatefulWidget {
  @override
  _ConfigurationScreenState createState() => _ConfigurationScreenState();
}

class _ConfigurationScreenState extends State<ConfigurationScreen> {
  List<dynamic> configurations = [];

  _getConfigurationsByUser(String uid) async {
    QuerySnapshot qs = await FirebaseFirestore.instance
        .collection('configurations')
        .where("user", isEqualTo: uid)
        .get();
    return qs.docs
        .map((element) => Map.from({
              "id": element.id,
              "cpu": element.data()['cpu'],
              "graphics_card": element.data()['graphics_card'],
              "motherboard": element.data()['motherboard'],
              "psu": element.data()['psu'],
              "ram": element.data()['ram'],
              "ssd": element.data()['ssd'],
              "case": element.data()['case'],
              "title": element.data()['title'],
              "description": element.data()['description'],
              "created_at": element.data()['created_at'],
            }))
        .toList();
  }

  @override
  void initState() {
    _getConfigurationsByUser(Provider.of<User>(context, listen: false).uid)
        .then((l) {
      setState(() {
        configurations = l;
      });
      print(configurations[0]);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          'Past Configurations',
        ),
        centerTitle: true,
        backgroundColor: Colors.pink,
        elevation: 20,
      ),
      body: Container(
        child: ListView.separated(
          separatorBuilder: (context, index) => Divider(
            color: Colors.black,
          ),
          itemCount: configurations.length != 0 ? configurations.length : 1,
          itemBuilder: (BuildContext context, int index) {
            if (configurations.length == 0)
              return Center(
                  child: Padding(
                padding: const EdgeInsets.all(23.0),
                child: Text('You have no configurations! Go Make some!'),
              ));
            else
              return Dismissible(
                key: Key(configurations[index]['id']),
                background: Container(
                    color: Colors.red,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    )),
                onDismissed: (direction) async {
                  // delete configuration with id from firestore;
                  await FirebaseFirestore.instance
                      .collection('configurations')
                      .doc(configurations[index]['id'])
                      .delete();
                  setState(() {
                    configurations.removeAt(index);
                  });
                  Fluttertoast.showToast(
                      msg: "Deleted configuration successfully!",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.SNACKBAR,
                      timeInSecForIosWeb: 3,
                      backgroundColor: Colors.pink,
                      textColor: Colors.white,
                      fontSize: 16.0);
                },
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Text(
                          configurations[index]['title'] ?? 'My Configuration',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          softWrap: true,
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Text(
                            timeago.format(
                                configurations[index]["created_at"].toDate()),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            softWrap: true,
                            style:
                                TextStyle(fontSize: 11.0, color: Colors.pink)),
                      )
                    ],
                  ),
                  trailing: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.black)),
                    color: Colors.black,
                    onPressed: () {
                      moveToPage(context,
                          ConfigurationDetailsScreen(configurations[index]));
                    },
                    child: Text('View More',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              );
          },
        ),
      ),
    ));
  }
}
