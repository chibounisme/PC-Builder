import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pcbuilder/services/auth.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthService _authService = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String email = "", password = "", repeatedPassword = "";

  bool creationErrorExists = false;
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
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: Text(
                  "Welcome Gamers!",
                  style: TextStyle(color: Color(0xFFBFE2851), fontSize: 28),
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: Text("Create your account",
                    style: TextStyle(color: Color(0xFFBB9B9B9), fontSize: 20)),
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
                                  hintText: 'Enter Email'),
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
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
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
                                  hintText: 'Enter Password'),
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
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
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
                                    hintText: 'Confirm Password'),
                                onChanged: (value) {
                                  setState(() => repeatedPassword = value);
                                },
                                validator: (val) {
                                  if (val.isEmpty || val != password) {
                                    return 'Please repeat the password';
                                  }
                                  return null;
                                }),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                        child: Center(
                      child: Text(
                          creationErrorExists == true
                              ? "There was an error creating the account"
                              : "",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.red, fontSize: 20)),
                    )),
                    SizedBox(height: 40),
                  ],
                ),
              ),
              Container(
                  child: GestureDetector(
                onTap: () async {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  setState(() => creationErrorExists = false);
                  if (_formKey.currentState.validate()) {
                    setState(() => loading = true);
                    print(email);
                    print(password);
                    print(repeatedPassword);
                    dynamic user = await _authService.register(email, password);
                    if (user == null) {
                      setState(() => loading = false);
                      setState(() => creationErrorExists = true);
                      print('Problem when creating the user');
                    } else {
                      // sahar mrigl
                      await FirebaseFirestore.instance
                          .collection('profile')
                          .doc(user.uid)
                          .set({
                        'name': 'Inconnu',
                        'photo':
                            'https://firebasestorage.googleapis.com/v0/b/flutter-pc-builder.appspot.com/o/inconnu.png?alt=media&token=8cfb4464-e364-425c-bee0-356953b32600',
                        'date': DateTime.now()
                      });
                      await FirebaseFirestore.instance
                          .collection('settings')
                          .doc(user.uid)
                          .set({"currency": "USD"});
                      Navigator.pop(context);
                      print(user);
                    }
                  } else {
                    print('Please type the correct information');
                  }
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFBFE2851),
                        borderRadius: BorderRadius.circular(50)),
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: loading
                          ? SpinKitDualRing(color: Colors.black, size: 22)
                          : Text(
                              "Create Account",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                    )),
              )),
              SizedBox(height: 20),
              Container(
                  child: GestureDetector(
                onTap: () {
                  Navigator.pop(context, true);
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFBFE2851), width: 2),
                      borderRadius: BorderRadius.circular(50)),
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: Text(
                      "Back to Login",
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
