import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:pcbuilder/utils/currencies.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  getUserCurrency(String uid) async {
    DocumentSnapshot qs =
        await FirebaseFirestore.instance.collection("settings").doc(uid).get();
    return qs.data();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
        backgroundColor: Colors.pink,
      ),
      body: FutureBuilder(
        future: getUserCurrency(user.uid),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.done)
            return SettingsList(
              sections: [
                SettingsSection(
                  tiles: [
                    SettingsTile(
                      title: 'Currency',
                      subtitle: snapshot.data["currency"],
                      leading: Icon(Icons.money),
                      onPressed: (_) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PickCurrency(
                                    snapshot.data["currency"], user.uid)));
                      },
                    ),
                  ],
                ),
              ],
            );
          return Center(child: SpinKitFadingCircle(color: Colors.pink));
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class PickCurrency extends StatefulWidget {
  String currentCurrency;
  String userUID;

  PickCurrency(this.currentCurrency, this.userUID);
  @override
  _PickCurrencyState createState() => _PickCurrencyState();
}

class _PickCurrencyState extends State<PickCurrency> {
  String selectedRadio;
  bool isLoading = false;

  @override
  void initState() {
    selectedRadio = widget.currentCurrency;
    super.initState();
  }

  loadData(data) async {
    setState(() {
      isLoading = true;
    });
    await FirebaseFirestore.instance
        .collection('settings')
        .doc(widget.userUID)
        .set({"currency": selectedRadio});

    GetIt.instance<Currencies>().currentCurrency = selectedRadio;
    GetIt.instance<Currencies>().currentConversionRate =
        await Currencies.getConversionRate("USD", selectedRadio);
    print(
        "New conversion rate is ${GetIt.instance<Currencies>().currentConversionRate}");
    Fluttertoast.showToast(
        msg: "Changed currency successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.pink,
        textColor: Colors.white,
        fontSize: 16.0);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SettingsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose your currency'),
        centerTitle: true,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => SettingsScreen()));
          },
        ),
        backgroundColor: Colors.pink,
      ),
      body: Material(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: Currencies.all.length,
                itemBuilder: (context, index) {
                  return RadioListTile(
                    title: Text(
                        "${Currencies.all[index]['name']} - ${Currencies.all[index]['code']}"),
                    value: Currencies.all[index]['code'],
                    groupValue: selectedRadio,
                    activeColor: Color(0xFF6200EE),
                    onChanged: (value) {
                      setState(() {
                        selectedRadio = value;
                        loadData(selectedRadio);
                      });
                    },
                  );
                },
              ),
            ),
            Expanded(
              child: Center(
                  child: isLoading
                      ? SpinKitFadingCircle(color: Colors.pink)
                      : Container()),
            )
          ],
        ),
      ),
    );
  }
}
