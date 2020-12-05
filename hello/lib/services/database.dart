//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserByUsername(String userName) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: userName)
        .get();
  }

  getUserByUserEmail(String userEmail) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: userEmail)
        .get();
  }

// you will have to use Future Void here , as it will upload to cloud firestore with async(for syncing)
  Future<void> uploadUserInfo(userMap) async {
    FirebaseFirestore.instance.collection("users").add(userMap).catchError((e) {
      print(e.toString());
    });
  }

  createChatroom(String chatroomid, dynamic chatroomMap) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatroomid)
        .set(chatroomMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  addConvMessage(String chatroomId, messageMap) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatroomId)
        .collection("chats")
        .add(messageMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  getConvoMessage(String chatroomId) async {
    return await FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatroomId)
        .collection("chats")
        .orderBy("time", descending: false)
        .snapshots();
    // .then(
    //     (QuerySnapshot querySnapshot) => querySnapshot.docs.forEach((doc) {
    //           print((doc["message"]));
    //         }));
  }

  getchatRrooms(String userName) async {
    return await FirebaseFirestore.instance
        .collection("ChatRoom")
        .where("users", arrayContains: userName)
        .snapshots();
  }
}
