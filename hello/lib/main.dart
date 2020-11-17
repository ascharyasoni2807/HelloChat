import 'package:flutter/material.dart';
import 'package:hello/pages/sigin.dart';
import 'package:hello/pages/signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        initialRoute: "/signup",
        routes: {"/": (context) => SignIn(), "/signup": (context) => SignUP()});
  }
}
