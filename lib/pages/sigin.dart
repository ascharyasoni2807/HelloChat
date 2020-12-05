// import 'dart:html';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hello/pages/designs.dart';
import 'package:hello/pages/chatroom.dart';
import 'package:hello/pages/signup.dart';
import 'package:hello/services/auth.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:hello/navigation/sharedpref.dart';
import 'package:hello/services/database.dart';
import 'package:hello/pages/google_sign_in.dart';

class SignIn extends StatefulWidget {
  //final Function toggle;

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formKey = GlobalKey<FormState>();
  var _authmethods = FirebaseAuth.instance;
  // Authmethods _authmethods = new Authmethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  DatabasesGoogleMethods databasesGoogleMethods = new DatabasesGoogleMethods();
  TextEditingController emailTextEditing = new TextEditingController();
  TextEditingController passwordTextEditing = new TextEditingController();
  bool isLoading = false;
  QuerySnapshot snapshotUserInfo;
  String email;
  String password;
  signIn() {
    if (formKey.currentState.validate()) {
      HelperFunctions.saveUserEmailSharedPreference(emailTextEditing.text);
      /* HelperFunctions.saveUserEmailSharedPreference(
            userNameTextEditingController.text);*/
      databaseMethods.getUserByUserEmail(emailTextEditing.text).then((value) {
        snapshotUserInfo = value;

        HelperFunctions.saveUserNameSharedPreference(
            snapshotUserInfo.docs[0].data()["name"]);
        print('${snapshotUserInfo.docs[0].data()["name"]}');
        print("nayaname hai");
      });

      setState(() {
        isLoading = true;
      });

      // ignore: deprecated_member_use
      _authmethods
          .signInWithEmailAndPassword(
              email: emailTextEditing.text, password: passwordTextEditing.text)
          .then((value) async {
        print(value);
        if (value != null) {
          HelperFunctions.saveUserLoggedInSharedPreference(true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChatRoom()));
        } else {
          print("not opened");
          print(value);
          setState(() {
            isLoading = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : Container(
              color: Colors.brown,
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height - 50,
                  alignment: Alignment.center,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              SizedBox(height: 40),
                              TextFormField(
                                onChanged: (value) {
                                  email = value;
                                },
                                validator: (value) {
                                  return RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(value)
                                      ? null
                                      : ' Please provide valid Email';
                                },
                                controller: emailTextEditing,
                                decoration:
                                    textFieldDecoration('Enter Email', 'Email'),
                                keyboardType: TextInputType.emailAddress,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                onChanged: (value) {
                                  password = value;
                                },
                                obscureText: true,
                                validator: (value) {
                                  return value.length > 6
                                      ? null
                                      : 'please enter min 6 char password';
                                },
                                controller: passwordTextEditing,
                                decoration: textFieldDecoration(
                                    'Enter password', 'Password'),
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              child: Text("Forgot Password?",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600))),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          // padding: EdgeInsets.symmetric(vertical: 10),
                          child: RaisedButton(
                            child: Text(
                              'Sign In',
                              style: TextStyle(fontSize: 16),
                            ),
                            onPressed: () async {
                              // CircularProgressIndicator(
                              //     backgroundColor: Colors.white,
                              //     strokeWidth: 5,
                              //     valueColor: new AlwaysStoppedAnimation<Color>(
                              //         Colors.brown));
                              signIn();
                              print("loged in seccesfully");
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            color: Colors.brown[800],
                            textColor: Colors.white,
                          ),
                        ),
                        SizedBox(height: 2),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          // padding: EdgeInsets.symmetric(vertical: 10),
                          child: RaisedButton(
                            child: Text('Sign In With Google',
                                style: TextStyle(fontSize: 16)),
                            onPressed: () {
                              databasesGoogleMethods
                                  .signInWithGoogle()
                                  .then((value) {
                                if (value != null) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ChatRoom()));
                                }
                              });
                              print("loged in seccesfully");
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            color: Colors.brown[800],
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
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),

                            //  padding: EdgeInsets.symmetric(vertical: 8),
                            InkWell(
                              child: Text(
                                " Register Now",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline),
                              ),
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUP()));
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}

class Fixerror extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        // child: Fluttertoast.showToast(
        //     msg: "email or password invalid",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.grey,
        //     textColor: Colors.white,
        //     fontSize: 16.0));
        );
  }
}
