import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_it/get_it.dart';
import 'package:pcbuilder/screens/homescreen.dart';

import 'package:pcbuilder/screens/registerscreen.dart';
import 'package:pcbuilder/services/auth.dart';
import 'package:pcbuilder/utils/currencies.dart';
import 'package:pcbuilder/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String email, password;
  String loginError = '';

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
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
                child: Text(
                  "Login To Continue",
                  style: TextStyle(color: Color(0xFFBB9B9B9), fontSize: 20),
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
                            borderRadius: BorderRadius.circular(50)),
                        child: Row(
                          children: <Widget>[
                            Container(
                                width: 60,
                                child: Icon(
                                  Icons.email,
                                  size: 20,
                                  color: Color(0xFFFFFFFFF),
                                )),
                            Expanded(
                              child: TextFormField(
                                style: TextStyle(color: Color(0xFFFFFFFF)),
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 20),
                                    border: InputBorder.none,
                                    hintText: "Enter Email.."),
                                onChanged: (value) {
                                  setState(() => email = value);
                                },
                                validator: (value) {
                                  bool emailValid = RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value);
                                  if (value.isEmpty || !emailValid) {
                                    return 'Please enter a valid email';
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
                            borderRadius: BorderRadius.circular(50)),
                        child: Row(
                          children: <Widget>[
                            Container(
                                width: 60,
                                child: Icon(
                                  Icons.vpn_key_sharp,
                                  size: 20,
                                  color: Color(0xFFFFFFFFF),
                                )),
                            Expanded(
                              child: TextFormField(
                                style: TextStyle(color: Color(0xFFFFFFFF)),
                                obscureText: true,
                                decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 20),
                                    border: InputBorder.none,
                                    hintText: "Enter Password"),
                                onChanged: (value) {
                                  setState(() => password = value);
                                },
                                validator: (value) {
                                  if (value.isEmpty || value.length < 6) {
                                    return 'Please enter a password with 6+ characters';
                                  }
                                  return null;
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                          child: Center(
                        child: Text(loginError,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.red, fontSize: 20)),
                      )),
                      SizedBox(height: 40),
                      Container(
                          child: GestureDetector(
                        onTap: () async {
                          // remove keyboard when tapping
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          setState(() => loginError = "");
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic user =
                                await _authService.login(email, password);
                            if (user == null) {
                              setState(() => loading = false);
                              setState(() => loginError =
                                  "Wrong Email/Password Combination");
                            } else {
                              DocumentSnapshot qs = await FirebaseFirestore
                                  .instance
                                  .collection("settings")
                                  .doc(user.uid)
                                  .get();

                              GetIt.instance<Currencies>().currentCurrency =
                                  qs.data()['currency'];
                              GetIt.instance<Currencies>()
                                      .currentConversionRate =
                                  await Currencies.getConversionRate(
                                      "USD", qs.data()['currency']);
                              print(
                                  "New conversion rate is ${GetIt.instance<Currencies>().currentConversionRate}");
                              moveToPage(context, HomeScreen());
                            }
                          }
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xFFBFE2851),
                                borderRadius: BorderRadius.circular(50)),
                            padding: EdgeInsets.all(20),
                            child: Center(
                              child: loading
                                  ? SpinKitDualRing(
                                      color: Colors.black, size: 22)
                                  : Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                            )),
                      )),
                    ],
                  )),
              SizedBox(height: 20),
              Container(
                  child: GestureDetector(
                onTap: () {
                  moveToPage(context, RegisterScreen());
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFBFE2851), width: 2),
                      borderRadius: BorderRadius.circular(50)),
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: Text(
                      "Create new Account",
                      style: TextStyle(color: Color(0xFFBFE2851), fontSize: 16),
                    ),
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
