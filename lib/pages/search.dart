import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hello/navigation/sharedpref.dart';
import 'package:hello/pages/appbar.dart';
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
                padding: EdgeInsets.symmetric(vertical: 2),
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
      color: Colors.white24,
      child: Row(
        children: [
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Text(userName),
                SizedBox(
                  height: 2,
                ),
                Text(userEmail)
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

              // createroomstartchat(userName: userName);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Chatscreen(chatroomId)));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(24)),
              child: Text(
                'Message',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          )
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
            padding: EdgeInsets.symmetric(horizontal: 22),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: searchtextedit,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search Friend Name",
                      hintStyle: TextStyle(color: Colors.white54)),
                )),
                Spacer(),
                // padding: EdgeInsets.symmetric(horizontal: 2),
                IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      searchinitiate();
                    })
              ],
            ),
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