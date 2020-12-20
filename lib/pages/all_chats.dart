import 'package:chat_app/firebase/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllChats extends StatefulWidget {
  String uid;

  AllChats(uid) {
    this.uid = uid;
  }

  @override
  _AllChatsState createState() => _AllChatsState();
}

class _AllChatsState extends State<AllChats> {
  @override
  initState() {
    Firestore.instance
        .collection("chats")
        .where(
          "users",
          arrayContains: "vbD9HHSnwzO8A81g8Dht",
        )
        .getDocuments()
        .then((value) => print(value.documents.length));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: Api('chats').streamDataCollection(),
            builder: (context, snapshot) {
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return Container(
                      child: Text(
                          snapshot.data.documents[index]['users'].toString()));
                },
              );
            }));
  }
}
