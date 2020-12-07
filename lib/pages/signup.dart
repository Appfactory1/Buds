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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white),
                    child: TextFormField(
                      //controller: password,
                      decoration: InputDecoration(
                          hintText: "password",
                          focusedBorder: InputBorder.none,
                          border: InputBorder.none),
                      onChanged: (value) => password = value,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forget Password?",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                      textAlign: TextAlign.left,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Center(
          child: Text(
            "Don't Have an Account ?",
            style: TextStyle(
                color: Colors.deepPurple[900],
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
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
                FirebaseUser user =
                    await Authentication().signUp(email, password);
                print('2');
                Api("users").addDocumentById({"email": email}, user.uid);
                print("3");

                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
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
