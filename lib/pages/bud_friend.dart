import 'package:chat_app/firebase/firestore.dart';
import 'package:chat_app/pages/chat.dart';
import 'package:chat_app/pages/edit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BudFriend extends StatefulWidget {
  @override
  _BudFriendState createState() => _BudFriendState();
}

class _BudFriendState extends State<BudFriend> {
  final Firestore tempfb = Firestore.instance;
  String uid;

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.currentUser().then((value) => uid = value.uid);
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.grey),
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(25)),
                height: 400,
                width: double.infinity,
                child: PageView(),
              ),
              SizedBox(height: 25),
              Text(
                "Name",
                style: TextStyle(color: Colors.grey[600], fontSize: 20),
              ),
              Text(
                "Work/Education",
                style: TextStyle(color: Colors.grey[600], fontSize: 20),
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Edit()));
                    },
                    icon: Icon(Icons.settings_outlined),
                    iconSize: 60,
                    color: Colors.grey,
                  ),
                  IconButton(
                    onPressed: () async {
                      QuerySnapshot u = await tempfb
                          .collection("chats")
                          .where("users", whereIn: [
                        [uid, "vbD9HHSnwzO8A81g8Dht"],
                        [
                          ["vbD9HHSnwzO8A81g8Dht", uid]
                        ]
                      ]).getDocuments();
                      print((u.documents.length).toString() + "length");
                      if (u.documents.length == 0) {
                        Api("chats").addDocument({
                          "users": uid + "vbD9HHSnwzO8A81g8Dht",
                        });
                      }
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Chat()));
                    },
                    icon: Icon(Icons.mail),
                    iconSize: 60,
                    color: Colors.grey,
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
