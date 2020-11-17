import 'package:flutter/material.dart';
import 'package:hello/pages/appbar.dart';

class SignUP extends StatefulWidget {
  @override
  _SignUPState createState() => _SignUPState();
}

class _SignUPState extends State<SignUP> {
  final formkey = GlobalKey<FormState>();

  TextEditingController userNameTextEditingController =
      new TextEditingController();
  TextEditingController emailTextEditing = new TextEditingController();
  TextEditingController passwordTextEditing = new TextEditingController();

  signselfUP() {
    if (formkey.currentState.validate()) {}
  }

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
                Form(
                  key: formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          return value.isEmpty || value.length < 6
                              ? "Username min of 6 characters"
                              : null;
                        },
                        controller: userNameTextEditingController,
                        decoration:
                            textFieldDecoration('Enter username', 'Username'),
                        // keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: emailTextEditing,
                        decoration: textFieldDecoration('Enter Email', 'Email'),
                        // keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: passwordTextEditing,
                        decoration:
                            textFieldDecoration('Enter password', 'Password'),
                        // keyboardType: TextInputType.emailAddress,
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      child: Text("Forgot Password?")),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  // padding: EdgeInsets.symmetric(vertical: 10),
                  child: RaisedButton(
                    child: Text('Sign Up'),
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
                    child: Text('Sign Up With Google'),
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
                      "Already have an account?",
                    ),
                    Text(
                      "Sign In Now",
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
