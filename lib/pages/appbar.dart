import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var fontdesign = GoogleFonts.lemonada(
    textStyle: TextStyle(color: Colors.white, letterSpacing: 3, fontSize: 14));

Widget appBarMain(BuildContext context) {
  return AppBar(
    title: Text('Hello Text'),
    backgroundColor: Colors.blue,
  );
}

InputDecoration textFieldDecoration(String hinttext, String labeltext) {
  return InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 3.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 1.0),
      ),
      labelText: labeltext,
      labelStyle: fontdesign,
      hintText: hinttext);
}
