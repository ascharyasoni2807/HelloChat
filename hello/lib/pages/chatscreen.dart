import 'package:flutter/material.dart';
import 'package:hello/navigation/savedata.dart';
import 'package:hello/pages/appbar.dart';
import 'package:hello/services/database.dart';

class Chatscreen extends StatefulWidget {
  final String chatroomId;
  Chatscreen(this.chatroomId);
  @override
  _ChatscreenState createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  DatabaseMethods _databaseMethods = new DatabaseMethods();
  TextEditingController messagetext = new TextEditingController();
  Stream chatMessagesList;

  Widget ChatMessageList() {
    return StreamBuilder(
      stream: chatMessagesList,
      builder: (context, snapshot) {
        return ListView.builder(
          itemCount: snapshot.data().doc.length,
          itemBuilder: (context, index) {
            return TileMessage(snapshot.data.doc[index].data["message"]);
          },
        );
      },
    );
  }

  sendMessage() {
    if (messagetext.text.isNotEmpty) {
      Map<String, String> messageMap = {
        "message": messagetext.text,
        "sendBy": Constants.myName
      };

      _databaseMethods.addConvMessage(widget.chatroomId, messageMap);
      messagetext.text = '';
    }
  }

  @override
  void initState() {
    DatabaseMethods().getConvoMessage(widget.chatroomId).then((value) {
      print(value);
      setState(() {
        messagetext = value;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Stack(
          children: [
            Container(
              color: Colors.blue,
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white12,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(5)),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      // color: Colors.yellow,
                      child: TextField(
                        controller: messagetext,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Type Message",
                            hintStyle: TextStyle(color: Colors.white54)),
                      ),
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    // padding: EdgeInsets.symmetric(horizontal: 2),
                    IconButton(
                        icon: Icon(Icons.send),
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
    );
  }
}

class TileMessage extends StatelessWidget {
  final String message;
  TileMessage(this.message);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(message),
    );
  }
}
