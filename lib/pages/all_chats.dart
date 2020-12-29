import 'package:chat_app/firebase/firestore.dart';
import 'package:chat_app/pages/chat.dart';
import 'package:chat_app/widgets/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllChats extends StatefulWidget {
  String uid;
  String email;
  String uname;
  int index;

  AllChats(uid, email, uname) {
    this.uid = uid;
    this.email = email;
    this.uname = uname;
  }

  @override
  _AllChatsState createState() => _AllChatsState();
}

class _AllChatsState extends State<AllChats> {
  List list;
  @override
  initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          toolbarHeight: 70,
          backgroundColor: Colors.deepPurple[900],
        ),
        drawer: MyDrawer(),
        body: StreamBuilder(
            stream:
                //Api('chats').streamDataCollectionWithWhere('users', widget.uid),
                Api('chats')
                    .streamDataCollectionWithWhereForChats('users', widget.uid),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    list = snapshot.data.documents[index]['usernames'];
                    list.remove(widget.email);
                    list.remove(widget.uname);
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Chat(
                                    snapshot.data.documents[index].documentID,
                                    widget.uid)));
                      },
                      child: ListView(shrinkWrap: true, children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            list[0].toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Divider(
                          height: 5,
                          color: Colors.black,
                        )
                      ]),
                    );
                  },
                );
              } else {
                return Center(
                  child: Text('No Chats!!'),
                );
              }
            }));
  }
}
