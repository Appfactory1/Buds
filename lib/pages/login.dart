import 'package:chat_app/pages/home.dart';
import 'package:chat_app/pages/signup.dart';
import 'package:flutter/material.dart';

import 'chat.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email;
  String password;

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
                  "Log In",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                TextfiedCustom(
                  name: "Email",
                ),
                TextfiedCustom(
                  name: "Password",
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
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SignUp()));
            },
            child: Text(
              "Don't Have an Account ?",
              style: TextStyle(
                  color: Colors.deepPurple[900],
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
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
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Chat()));
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
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
