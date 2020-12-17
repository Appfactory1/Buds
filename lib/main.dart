import 'package:chat_app/pages/account_settings.dart';
import 'package:chat_app/pages/bud_friend.dart';
import 'package:chat_app/pages/buds.dart';
import 'package:chat_app/pages/home.dart';
import 'package:chat_app/pages/interest.dart';
import 'package:chat_app/pages/login.dart';
import 'package:chat_app/pages/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'pages/chat.dart';
import 'pages/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Chat',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: _home());
  }

  Widget _home() {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return Buds(null, null, "", []);
        } else {
          return Login();
        }
      },
    );
  }
}
