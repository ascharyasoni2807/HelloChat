import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello/navigation/savedata.dart';
import 'package:hello/navigation/sharedpref.dart';
import 'package:hello/pages/designs.dart';
import 'package:hello/pages/chatscreen.dart';
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
  Stream chatroomstream;

  Widget chatRoomList() {
    return StreamBuilder(
        stream: chatroomstream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return Chatroomtile(
                      userName: snapshot.data.docs[index]
                          .data()["chatroomId"]
                          .toString()
                          .replaceAll("_", "")
                          .replaceAll(Constants.myName, ""),
                      chatRoomId:
                          snapshot.data.docs[index].data()["chatroomId"],
                    );
                  })
              : Container();
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    print('heeloji');
    Constants.myName = await HelperFunctions.getUsernameSharedPreference();
    databaseMethods.getchatRrooms(Constants.myName).then((value) {
      setState(() {
        chatroomstream = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[800],
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
      body: Container(
        color: Colors.brown,
        child: Column(
          children: [chatRoomList()],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown[900],
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Searchscreen()));
        },
      ),
    );
  }
}

class Chatroomtile extends StatelessWidget {
  final String userName;
  final String chatRoomId;
  Chatroomtile({this.userName, this.chatRoomId});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(chatRoomId);
        print("innnnnnn");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Chatscreen(chatRoomId)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 5),
        color: Colors.black26,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          children: [
            Container(
              //
              height: 40,
              alignment: Alignment.center,
              width: 40,
              decoration: BoxDecoration(
                  color: Colors.orange[600],
                  borderRadius: BorderRadius.circular(40)),
              child: Text("${userName.substring(0, 1).toUpperCase()}",
                  style: GoogleFonts.hammersmithOne(
                      textStyle: TextStyle(
                          color: Colors.black,
                          letterSpacing: 3,
                          fontSize: 18))),
            ),
            SizedBox(
              width: 8,
            ),
            Text(userName,
                style: GoogleFonts.hammersmithOne(
                    textStyle: TextStyle(
                        color: Colors.white, letterSpacing: 3, fontSize: 18))),
          ],
        ),
      ),
    );
  }
}
