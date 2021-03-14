import 'package:chat_app/firebase/auth.dart';
import 'package:chat_app/firebase/firestore.dart';
import 'package:chat_app/pages/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email = "";
  String password = "";
  bool visible = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final snackBar = SnackBar(content: Text('Account has been setup'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(height: 35),
            Center(
                child: Text(
              "Welcome To Buds",
              style: TextStyle(color: Colors.grey, fontSize: 30),
            )),
            SizedBox(height: 280),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45),
              child: Container(
                height: 250,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    color: Colors.deepPurple[900]),
                child: Column(
                  children: [
                    SizedBox(
                      height: 70,
                    ),
                    Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 8),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white),
                        child: TextFormField(
                          //controller: email,
                          decoration: InputDecoration(
                              hintText: "email",
                              focusedBorder: InputBorder.none,
                              border: InputBorder.none),
                          onChanged: (value) => email = value,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 8),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white),
                        child: TextFormField(
                          obscureText: visible,
                          //controller: password,
                          decoration: InputDecoration(
                              hintText: "Password",
                              focusedBorder: InputBorder.none,
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                icon: Icon(visible
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    visible = !visible;
                                  });
                                },
                              )),
                          onChanged: (value) => password = value,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 55),
              child: Container(
                height: 50,
                //decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.deepPurple[900],
                  onPressed: () async {
                    print('1');
                    Authentication().signUp(email, password).then((user) {
                      if (user != null) {
                        _scaffoldKey.currentState.showSnackBar(
                            SnackBar(content: Text('Account has been setup')));
                      }
                      print('2');
                      Api("users").addDocumentById({"email": email}, user.uid);
                      print("3");

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    }).catchError((e) {
                      _scaffoldKey.currentState
                          .showSnackBar(SnackBar(content: Text(e.message)));
                    });
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
            // PhotoView(
            //   imageProvider: AssetImage("assets/main screen.jpg"),
            // )
          ],
        ));
  }

  Widget textfiedCustom({controller, name}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
              hintText: name,
              focusedBorder: InputBorder.none,
              border: InputBorder.none),
        ),
      ),
    );
  }
}

// class TextfiedCustom extends StatelessWidget {
//   final String name;
//   final TextEditingController controller;
//   const TextfiedCustom({
//     this.controller,
//     this.name,
//     Key key,
//   }) : super(key: key);

//   @override

// }
