import 'package:flutter/material.dart';
import 'package:hello/pages/appbar.dart';

class Searchscreen extends StatefulWidget {
  @override
  _SearchscreenState createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  TextEditingController searchtextedit = new TextEditingController();

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

                // padding: EdgeInsets.symmetric(horizontal: 2),
                Container(
                  child: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
