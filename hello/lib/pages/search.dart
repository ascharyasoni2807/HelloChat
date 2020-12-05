import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hello/navigation/sharedpref.dart';
import 'package:hello/pages/designs.dart';
import 'package:hello/services/database.dart';
import 'package:hello/pages/chatscreen.dart';
import 'package:hello/navigation/savedata.dart';
import 'package:hello/pages/search.dart';

class Searchscreen extends StatefulWidget {
  @override
  _SearchscreenState createState() => _SearchscreenState();
}

String _myName;
String chatroomId;

class _SearchscreenState extends State<Searchscreen> {
  TextEditingController searchtextedit = new TextEditingController();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  QuerySnapshot searchSnapshot;

  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            itemCount: searchSnapshot.docs.length,
            shrinkWrap: true,
            // padding:,
            itemBuilder: (context, index) {
              return Container(
                color: Colors.brown[800],
                padding: EdgeInsets.symmetric(vertical: 4),
                child: SearchTile(
                  userName: searchSnapshot.docs[index].data()["name"],
                  userEmail: searchSnapshot.docs[index].data()["email"],
                ),
              );
            })
        : Container();
  }

  searchinitiate() {
    databaseMethods.getUserByUsername(searchtextedit.text).then((value) {
      print(value.toString());
      print("hello");
      setState(() {
        searchSnapshot = value;
      });
      print(searchSnapshot);
    });
  }

  createroomstartchat({String userName}) {
    //  print(Constants.myName);

    if (userName != Constants.myName) {
      print(userName);
      chatroomId = getChatRoomId(userName, Constants.myName);
      print(userName);
      print('${Constants.myName}');
      List<String> users = [userName, Constants.myName];
      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatroomId": chatroomId,
      };

      databaseMethods.createChatroom(chatroomId, chatRoomMap);
      // CircularProgressIndicator(
      //     backgroundColor: Colors.white,
      //     strokeWidth: 5,
      //     valueColor: new AlwaysStoppedAnimation<Color>(Colors.brown));
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Chatscreen(chatroomId),
          ));
    } else {
      print("cant send message to self");
    }
  }

  Widget SearchTile({String userName, String userEmail}) {
    return Container(
      child: Row(
        children: [
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Text(
                  userName,
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(userEmail, style: TextStyle(color: Colors.white))
              ],
            ),
          ),
          Spacer(),
          /* Container(
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.message_outlined),
            ),
          )*/
          GestureDetector(
              onTap: () {
                print(userName);
                createroomstartchat(userName: userName);
                print('insearch');
                print(chatroomId);
                showLoaderDialog(BuildContext context) {
                  AlertDialog alert = AlertDialog(
                    content: new Row(
                      children: [
                        CircularProgressIndicator(),
                        Container(
                            margin: EdgeInsets.only(left: 7),
                            child: Text("Loading...")),
                      ],
                    ),
                  );
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                }

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Chatscreen(chatroomId)));
              },
              child: Container(
                height: 16,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                //color: Colors.brown, borderRadius: BorderRadius.circular(30)),
                child: Icon(
                  Icons.message,
                  color: Colors.white,
                ),
              )),
        ],
      ),
    );
  }

  @override
  void initState() {
    //getUserInfo();
    super.initState();
  }

  // getUserInfo() async {
  //   _myName = await HelperFunctions.getUsernameSharedPreference();
  //   setState(() {});
  //   print(_myName);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
          color: Colors.brown,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white12,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.symmetric(
                  horizontal: 22,
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: searchtextedit,
                      decoration: InputDecoration(
                          fillColor: Colors.brown[800],
                          border: InputBorder.none,
                          hintText: "Search Friend Name",
                          hintStyle: TextStyle(color: Colors.white)),
                    )),
                    Spacer(),
                    // padding: EdgeInsets.symmetric(horizontal: 2),
                    IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          searchinitiate();
                          // CircularProgressIndicator(
                          //     backgroundColor: Colors.white,
                          //     strokeWidth: 5,
                          //     valueColor:
                          //         new AlwaysStoppedAnimation<Color>(Colors.brown));
                        })
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              searchList(),
            ],
          )),
    );
  }

// class SearchTile extends StatelessWidget {
//   final String userName;
//   final String userEmail;
//   SearchTile({this.userName, this.userEmail});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white24,
//       child: Row(
//         children: [
//           Column(
//             children: [
//               Text(userName),
//               SizedBox(
//                 height: 2,
//               ),
//               Text(userEmail)
//             ],
//           ),
//           Spacer(),
//           /* Container(
//             child: IconButton(
//               onPressed: () {},
//               icon: Icon(Icons.message_outlined),
//             ),
//           )*/
//           Container(
//             child: RaisedButton(
//               onPressed: () {
//                 //     createroomstartchat(userName: userName);
//                 Navigator.pushReplacement(context,
//                     MaterialPageRoute(builder: (context) => Chatscreen()));
//               },
//               child: Column(
//                 children: [IconButton(icon: Icon(Icons.message)
//                 ,onPressed:() {
//                 //  createroomstartchat()
//                 }
//                 ), Text("Message")],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
