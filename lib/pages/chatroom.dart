import 'package:flutter/material.dart';
import 'package:hello/navigation/savedata.dart';
import 'package:hello/navigation/sharedpref.dart';
import 'package:hello/pages/search.dart';
import 'package:hello/pages/sigin.dart';
import 'package:hello/services/auth.dart';
import 'package:hello/services/database.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

String userName;

class _ChatRoomState extends State<ChatRoom> {
  Authmethods _authmethods = new Authmethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  @override
  void initState() {
    // TODO: implement initState
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    print('heeloji');
    Constants.myName = await HelperFunctions.getUsernameSharedPreference();
    setState(() {});
    print(Constants.myName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Friends List'),
        actions: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  _authmethods.signOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SignIn()));
                },
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Searchscreen()));
        },
      ),
    );
  }
}
