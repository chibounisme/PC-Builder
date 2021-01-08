import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:pcbuilder/models/configuration.dart';
import 'package:pcbuilder/utils/utils.dart';
import 'package:provider/provider.dart';

import 'homescreen.dart';

class SaveConfig extends StatefulWidget {
  @override
  _SaveConfigState createState() => _SaveConfigState();
}

class _SaveConfigState extends State<SaveConfig> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _title, _description;
  String _saveError = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Save your config"),
          backgroundColor: Colors.pink,
          elevation: 20,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 25),
                child: Center(
                  child: Image.asset("assets/images/logo_image.png", scale: 2),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Align(
                  child: Text(
                    "Dear Gamer,Save it",
                    style: TextStyle(color: Color(0xFFBB9B9B9), fontSize: 20),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Color(0xFFBC7C7C7), width: 2),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: <Widget>[
                            Container(
                                width: 60,
                                child: Icon(
                                  Icons.account_box_sharp,
                                  size: 20,
                                  color: Colors.black,
                                )),
                            Expanded(
                              child: TextFormField(
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        fontSize: 16.0, color: Colors.black),
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 20),
                                    border: InputBorder.none,
                                    hintText: "Enter Configuration title.."),
                                onChanged: (value) {
                                  setState(() => _title = value);
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
                      SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Color(0xFFBC7C7C7), width: 2),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: <Widget>[
                            Container(
                                width: 60,
                                child: Icon(
                                  Icons.description,
                                  size: 20,
                                  color: Colors.black,
                                )),
                            Expanded(
                              child: TextFormField(
                                maxLines: 3,
                                keyboardType: TextInputType.multiline,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        fontSize: 16.0, color: Colors.black),
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 20),
                                    border: InputBorder.none,
                                    hintText:
                                        "\n" + "Enter a short Description.."),
                                onChanged: (value) {
                                  setState(() => _description = value);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                          child: Center(
                        child: Text(_saveError,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.red, fontSize: 20)),
                      )),
                      Container(
                          child: GestureDetector(
                        onTap: () async {
                          // remove keyboard when tapping
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          setState(() => _saveError = "");
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            //ajouter les élements a la base
                            User user =
                                Provider.of<User>(context, listen: false);
                            Configuration conf =
                                GetIt.instance<Configuration>();
                            await FirebaseFirestore.instance
                                .collection('configurations')
                                .add({
                              "title": _title,
                              "description": _description,
                              "user": user.uid,
                              "created_at": DateTime.now(),
                              "cpu": conf.cpu.id,
                              "graphics_card": conf.graphicsCard.id,
                              "motherboard": conf.motherboard.id,
                              "psu": conf.psu.id,
                              "ram": conf.ram.id,
                              "ssd": conf.ssd.id,
                              "case": conf.hcase.id
                            });
                            moveToPage(context, HomeScreen());
                            Fluttertoast.showToast(
                                msg: "Added configuration successfully!",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.SNACKBAR,
                                timeInSecForIosWeb: 5,
                                backgroundColor: Colors.pink,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xFFBFE2851),
                                borderRadius: BorderRadius.circular(50)),
                            padding: EdgeInsets.all(20),
                            child: Align(
                              alignment: Alignment.center,
                              widthFactor: 3,
                              child: Text(
                                "Save",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            )),
                      )),
                    ],
                  )),
              SizedBox(
                width: 40,
              )
            ],
          ),
        ));
  }
}
