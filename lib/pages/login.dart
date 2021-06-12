import 'package:chat_app/firebase/auth.dart';
import 'package:chat_app/firebase/firestore.dart';
import 'package:chat_app/pages/home.dart';
import 'package:chat_app/pages/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'chat.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String email;
  String password;
  String uid;
  double height;
  double width;
  bool visible = true;
  final snackBar = SnackBar(content: Text('Email or password is incorrect'));

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
                child: Text(
              "Welcome To Buds",
              style: TextStyle(color: Colors.grey, fontSize: height * 30),
            )),
            //SizedBox(height: 280),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 45),
              child: Stack(
                children: [
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
                              "Log In",
                              style: TextStyle(
                                  color: Colors.white, fontSize: height * 25),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 25, vertical: height * 8),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 10),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Colors.white),
                                child: TextFormField(
                                  //controller: email,
                                  decoration: InputDecoration(
                                    hintText: "Email",
                                    focusedBorder: InputBorder.none,
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (value) => email = value,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 25, vertical: height * 8),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 10),
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
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 25.0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Authentication().resetPassword(email);
                                    _scaffoldKey.currentState.showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'We have sent an email to you.')));
                                  },
                                  child: Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: height * 12),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                            )
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
                ],
              ),
            ),
            SizedBox(
              height: height * 2,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUp()));
                },
                child: Text(
                  "Don't Have an Account ?",
                  style: TextStyle(
                      color: Colors.deepPurple[900],
                      fontSize: height * 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
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
                  onPressed: () {
                    //
                    Authentication().logIn(email, password).then((value) {
                      uid = value.uid;

                      if (value.isEmailVerified) {
                        Api('users')
                            .getDataCollectionWithWhere('email', email)
                            .then((value) {
                          if (value.documents.length == 0) {
                            Api("users").addDocumentById(
                                {"email": email, "uid": uid}, uid);
                          }
                        });
                      } else {
                        _scaffoldKey.currentState.showSnackBar(
                            SnackBar(content: Text("email isn't verified")));
                      }
                    }).catchError((e) {
                      print(e.message.toString() + 'phu');
                      _scaffoldKey.currentState
                          .showSnackBar(SnackBar(content: Text(e.message)));
                    });
                  },
                  child: Text(
                    "Log In",
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
}

class TextfiedCustom extends StatelessWidget {
  final String name;
  const TextfiedCustom({
    this.name,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 797.714;
    var width = MediaQuery.of(context).size.width / 411.4266;
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: width * 25, vertical: height * 8),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: width * 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white),
        child: TextFormField(
          decoration: InputDecoration(
              hintText: name,
              focusedBorder: InputBorder.none,
              border: InputBorder.none),
        ),
      ),
    );
  }
}
