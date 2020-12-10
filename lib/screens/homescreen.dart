import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:pcbuilder/screens/loginscreen.dart';
import 'package:pcbuilder/services/auth.dart';
import 'package:pcbuilder/utils/utils.dart';

class HomeScreen extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlatButton(
            child: Text('Logout'),
            onPressed: () async {
              await _authService.logout();
              moveToPage(context, LoginScreen());
            }),
      ),
    );
  }
}
