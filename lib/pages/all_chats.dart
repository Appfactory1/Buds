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
  String last;
  Timestamp time;
  String name;
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
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    list = snapshot.data.documents[index]['usernames'];
                    list.remove(widget.email);
                    list.remove(widget.uname);
                    name = list[0].toString();

                    last = snapshot.data.documents[index]['msg'] != null
                        ? snapshot.data.documents[index]['msg']
                        : "";
                    time = snapshot.data.documents[index]['time'];
                    print(time);
                    return GestureDetector(
                      onTap: () {
                        print(list[0].toString() + " passed");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Chat(
                                    snapshot.data.documents[index].documentID,
                                    widget.uid,
                                    snapshot.data.documents[index]['usernames'],
                                    widget.email,
                                    widget.uname,
                                    snapshot.data.documents[index]['users'])));
                      },
                      child: ListView(shrinkWrap: true, children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, left: 8.0, right: 8.0, bottom: 5.0),
                          child: Text(
                            list[0].toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 12.0, right: 8.0, bottom: 5),
                          child: Text(
                            last,
                            style: TextStyle(fontSize: 15, color: Colors.grey),
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
