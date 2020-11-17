import 'package:flutter/material.dart';
import 'package:hello/pages/appbar.dart';
//import 'package:google_fonts/google_fonts.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 50,
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 40),
                TextField(
                  decoration: textFieldDecoration('Enter Email', 'Email'),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: textFieldDecoration('Enter password', 'Password'),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      child: Text("Forgot Password?")),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  // padding: EdgeInsets.symmetric(vertical: 10),
                  child: RaisedButton(
                    child: Text('Sign In'),
                    onPressed: () {
                      print("loged in seccesfully");
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    color: Colors.blueGrey,
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(height: 2),
                Container(
                  width: MediaQuery.of(context).size.width,
                  // padding: EdgeInsets.symmetric(vertical: 10),
                  child: RaisedButton(
                    child: Text('Sign In With Google'),
                    onPressed: () {
                      print("loged in seccesfully");
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    color: Colors.blueGrey,
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Dont have an account?",
                    ),
                    Text(
                      "Register Now",
                      style: TextStyle(decoration: TextDecoration.underline),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
