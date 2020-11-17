import 'package:flutter/material.dart';
import 'package:hello/pages/appbar.dart';
import 'package:hello/services/auth.dart';
import 'package:hello/pages/chatroom.dart';

class SignUP extends StatefulWidget {
  @override
  _SignUPState createState() => _SignUPState();
}

class _SignUPState extends State<SignUP> {
  bool isLoading = false;

  Authmethods _authmethods = new Authmethods();

  final formkey = GlobalKey<FormState>();

  TextEditingController userNameTextEditingController =
      new TextEditingController();
  TextEditingController emailTextEditing = new TextEditingController();
  TextEditingController passwordTextEditing = new TextEditingController();

  signselfUP() {
    if (formkey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      _authmethods
          .signUpWithWmailAndPassword(
              emailTextEditing.text, passwordTextEditing.text)
          .then((value) {
        print(value);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ChatRoom()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading
          ? Container(child: Center(child: CircularProgressIndicator()))
          : SingleChildScrollView(
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
                                    ? "Enter Valid Username"
                                    : null;
                              },
                              controller: userNameTextEditingController,
                              decoration: textFieldDecoration(
                                  'Enter username min 6 characters',
                                  'Username'),
                              // keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
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
                              // keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              obscureText: true,
                              validator: (value) {
                                return value.length > 6
                                    ? null
                                    : 'please enter min 6 char password';
                              },
                              controller: passwordTextEditing,
                              decoration: textFieldDecoration(
                                  'Enter password', 'Password'),
                              // keyboardType: TextInputType.emailAddress,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            child: Text("Forgot Password?")),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        // padding: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          children: [
                            RaisedButton(
                              child: Text('Sign Up'),
                              onPressed: () {
                                signselfUP();
                                print("loged in seccesfully");
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              color: Colors.blueGrey,
                              textColor: Colors.white,
                            ),
                          ],
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
                            style:
                                TextStyle(decoration: TextDecoration.underline),
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
