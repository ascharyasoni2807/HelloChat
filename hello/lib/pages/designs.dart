import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var fontdesign = GoogleFonts.pacifico(
    textStyle: TextStyle(color: Colors.black, letterSpacing: 3, fontSize: 14));

Widget appBarMain(BuildContext context) {
  return AppBar(
    title: Text('Hello Text'),
    backgroundColor: Colors.brown[800],
  );
}

InputDecoration textFieldDecoration(String hinttext, String labeltext) {
  return InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.brown[900], width: 3.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.brown[900], width: 1.0),
    ),
    labelText: labeltext,
    labelStyle: GoogleFonts.pacifico(
        textStyle:
            TextStyle(color: Colors.black, letterSpacing: 3, fontSize: 18)),
    hintText: hinttext,
    hintStyle: GoogleFonts.pacifico(
        textStyle:
            TextStyle(color: Colors.black, letterSpacing: 3, fontSize: 16)),
  );
}
