import 'package:flutter/material.dart';
import 'package:hello/navigation/aunthenticate.dart';
import 'package:hello/navigation/sharedpref.dart';
import 'package:hello/pages/chatroom.dart';
import 'package:hello/pages/chatscreen.dart';
import 'package:hello/pages/search.dart';
// ignore: unused_import
import 'package:hello/pages/sigin.dart';
import 'package:hello/pages/signup.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn = false;
  @override
  void initState() {
    // TODO: implement initState
    getLoggedinState();

    super.initState();
  }

  getLoggedinState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
      setState(() {
        print(value);
        print("batao");
        userIsLoggedIn = value;
      });
      //   userIsLoggedIn = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.brown),
        debugShowCheckedModeBanner: false,
        home: userIsLoggedIn ? ChatRoom() : Authenticate());
  }
}

class blank extends StatefulWidget {
  @override
  _blankState createState() => _blankState();
}

class _blankState extends State<blank> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
