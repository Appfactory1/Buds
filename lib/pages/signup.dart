import 'package:chat_app/firebase/auth.dart';
import 'package:chat_app/firebase/firestore.dart';
import 'package:chat_app/pages/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'login.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final colorizeColors = [
    Colors.purple,
    Colors.purple.shade100,
    Colors.purple.shade200,
    Colors.purple.shade300,
    Colors.purple.shade400,
    Colors.purple.shade500,
    Colors.purple.shade600,
    Colors.purple.shade700,
    Colors.purple.shade800,
    Colors.purple.shade900,
  ];
  final colorizeTextStyle = TextStyle(
    fontSize: 30.0,
    fontFamily: 'Horizon',
    fontWeight: FontWeight.bold,
  );
  String email = "";
  String password = "";
  bool visible = true;
  double height;
  double width;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final snackBar = SnackBar(
      content:
          Text('Account has been setup, verify your email before logging in'));

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height / 797.714;
    width = MediaQuery.of(context).size.width / 411.4266;
    return Scaffold(
        key: _scaffoldKey,
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(height: height * 35),
            Center(
                child: Column(children: [
              Text(
                'Welcome to ',
                style: TextStyle(
                  fontSize: height * 30.0,
                  fontFamily: 'Horizon',
                ),
              ),
              AnimatedTextKit(animatedTexts: [
                ColorizeAnimatedText(
                  'Buds',
                  textStyle: colorizeTextStyle,
                  colors: colorizeColors,
                  speed: Duration(milliseconds: 200),
                ),
              ])
            ])),
            //SizedBox(height: 280),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: (45.0 * width)),
              child: Stack(children: [
                Column(
                  children: [
                    Container(
                      height: height * 300,
                    ),
                    Container(
                      height: height * 250,
                      width: width * 350,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          color: Colors.deepPurple[900]),
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 70,
                          ),
                          Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Colors.white, fontSize: height * 25),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: width * 25, vertical: height * 8),
                            child: Container(
                              padding:
                                  EdgeInsets.symmetric(horizontal: width * 10),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
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
                            padding: EdgeInsets.symmetric(
                                horizontal: width * 25, vertical: height * 8),
                            child: Container(
                              padding:
                                  EdgeInsets.symmetric(horizontal: width * 10),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
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
                                          ? Icons.visibility_off
                                          : Icons.visibility),
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
                  ],
                ),
                Positioned(
                    bottom: height * 120,
                    right: -width * 40,
                    child: Image(
                        height: height * 400,
                        image: AssetImage('assets/Bean.png'))),
                Image(
                    height: height * 400,
                    image: AssetImage('assets/illustration.png'))
              ]),
            ),
            SizedBox(
              height: height * 2,
            ),
            SizedBox(
              height: height * 8,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 55),
              child: Container(
                height: height * 50,
                //decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.deepPurple[900],
                  onPressed: () async {
                    print('1');
                    Authentication().signUp(email, password).then((user) {
                      if (user != null) {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text(
                                'Account has been setup, verify your email before logging in')));
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
      padding:
          EdgeInsets.symmetric(horizontal: width * 25, vertical: height * 8),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: width * 10),
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
