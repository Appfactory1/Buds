import 'package:chat_app/firebase/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllChats extends StatefulWidget {
  @override
  _AllChatsState createState() => _AllChatsState();
}

class _AllChatsState extends State<AllChats> {
  @override
  Widget build(BuildContext context) {
    initState() {
      Firestore.instance
          .collection("chats")
          .where(
            "users",
            isGreaterThan: "vbD9HHSnwzO8A81g8Dht",
          )
          .getDocuments()
          .then((value) => print('done'));
    }

    return Scaffold(
        body: StreamBuilder(
            stream: Api('chats').streamDataCollection(),
            builder: (context, snapshot) {
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return Container(
                      child: Text(snapshot.data.documents[index]['users'][1]));
                },
              );
            }));
  }
}
