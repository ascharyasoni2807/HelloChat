import 'package:flutter/material.dart';
import 'package:hello/pages/sigin.dart';
import 'package:hello/pages/signup.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showsignin = false;
  // value changing of signinview ( if false then change to true , vicecversa)
  void toggling() {
    setState(() {
      showsignin = !showsignin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showsignin) {
      return SignIn();
    } else {
      return SignUP();
    }
  }
}
