import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hello/navigation/savedata.dart';
import 'package:hello/pages/designs.dart';
import 'package:hello/pages/search.dart';
import 'package:hello/services/database.dart';

class Chatscreen extends StatefulWidget {
  final String chatroomId;
  Chatscreen(this.chatroomId);
  @override
  _ChatscreenState createState() => _ChatscreenState();
}

Stream chatMessageStream;

class _ChatscreenState extends State<Chatscreen> {
  DatabaseMethods _databaseMethods = new DatabaseMethods();
  TextEditingController messagetext = new TextEditingController();
  // Stream chatMessageStream;
  // Widget chatMessageList() {
  //   return StreamBuilder(
  //       stream: chatMessageStream,
  //       builder: (context, snapshot) {
  //         return ListView.builder(
  //             itemCount: snapshot.data.docs.length,
  //             itemBuilder: (context, index) {
  //               return TileMessage(snapshot.data.docs[index].data()["message"]);
  //             });
  //       });
  // }

  sendMessage() {
    if (messagetext.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": messagetext.text,
        "sendBy": Constants.myName,
        "time": DateTime.now().millisecondsSinceEpoch,
      };

      _databaseMethods.addConvMessage(widget.chatroomId, messageMap);
      messagetext.text = '';
    }
  }

  @override
  void initState() {
    DatabaseMethods().getConvoMessage(widget.chatroomId).then((value) {
      print(value);
      print('heelo init');
      setState(() {
        chatMessageStream = value;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chatroomId
            .toString()
            .replaceAll("_", "")
            .replaceAll(Constants.myName, "")),
        backgroundColor: Colors.brown[800],
      ),
      body: SafeArea(
        child: Container(
          color: Colors.brown,
          child: Stack(
            children: [
              ChatMessageList(),
              Container(
                padding: EdgeInsets.only(bottom: 10),
                //  color: Colors.blue,
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.brown,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(25)),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                        // color: Colors.yellow,
                        child: TextField(
                          controller: messagetext,
                          decoration: InputDecoration(
                              fillColor: Colors.brown,
                              //border: OutlineInputBorder(
                              //  borderRadius: BorderRadius.circular(10)),
                              hintText: "Type Message",
                              hintStyle: TextStyle(color: Colors.white)),
                        ),
                      )),
                      SizedBox(
                        width: 10,
                      ),
                      // padding: EdgeInsets.symmetric(horizontal: 2),
                      IconButton(
                          icon: Icon(
                            Icons.send,
                          ),
                          onPressed: () {
                            sendMessage();
                            // searchinitiate();
                          })
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TileMessage extends StatelessWidget {
  final String message;
  final bool isSendByMe;
  TileMessage(this.message, this.isSendByMe);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.symmetric(horizontal: 6),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: isSendByMe
                    ? [Colors.brown[700], Colors.brown[900]]
                    : [Colors.brown[700], Colors.brown[600]]),
            borderRadius: isSendByMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23))
                : BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23),
                  )),
        // height: 15,

        child: Text(
          message,
          style: TextStyle(color: Colors.white, letterSpacing: 2, fontSize: 14),
        ),
      ),
    );
  }
}

class ChatMessageList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: chatMessageStream,
        builder: (context, snapshot) {
          print(snapshot.data);
          print('inside ot');
          if (snapshot.data == null) return CircularProgressIndicator();
          return ListView.builder(
              // print('hello in list');
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                return TileMessage(
                    snapshot.data.docs[index].data()["message"],
                    snapshot.data.docs[index].data()["sendBy"] ==
                        Constants.myName);
              });
        });
  }
}
