import 'package:chat_app/firebase/firestore.dart';
import 'package:chat_app/pages/chatProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  String id;
  String uid;
  List name;
  String email;
  String uname;
  List uids;

  Chat(
      String id, String uid, List name, String email, String uname, List uids) {
    this.id = id;
    this.uid = uid;
    this.name = name;
    this.email = email;
    this.uname = uname;
    this.uids = uids;
  }
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final Firestore tempfb = Firestore.instance;

  String uid;
  String msg;
  final myController = TextEditingController();
  QuerySnapshot u;
  List _list;
  List _listuid;

  @override
  Widget build(BuildContext context) {
    _list = widget.name;
    _list.remove(widget.email);
    _list.remove(widget.uname);

    _listuid = widget.uids;
    _listuid.remove(widget.uid);
    print(_listuid[0]);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: GestureDetector(
              onTap: () {
                print(_listuid[0]);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileChat(_listuid[0])));
              },
              child: Text(_list[0])),
          iconTheme: IconThemeData(color: Colors.white),
          toolbarHeight: 70,
          backgroundColor: Colors.deepPurple[900],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 4,
              ),
              Expanded(
                child: ListView(
                  reverse: true,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  //crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    StreamBuilder(
                        stream: Api("chats/" + widget.id + "/msgs")
                            .streamDataCollectionordered(),
                        builder: (BuildContext context, snapshot) {
                          return snapshot.data != null
                              ?
                              // ? Expanded(
                              //     child:
                              ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.documents.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return snapshot.data.documents == null
                                        ? Container()
                                        : (snapshot.data.documents[index]
                                                    ['sender'] ==
                                                widget.uid)
                                            ? sending(snapshot
                                                .data.documents[index]['msg'])
                                            : recieving(snapshot
                                                .data.documents[index]['msg']);
                                  },
                                )
                              // )
                              : Container();
                        })
                  ],
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: myController,
                        onChanged: (value) {
                          msg = value;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          hintText: 'Type your message here...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: () async {
                        //user = await _auth.currentUser();

                        Api('chats').updateDocument(
                            {'msg': myController.text, 'time': DateTime.now()},
                            widget.id);

                        Api("chats/" + widget.id + "/msgs").addDocument({
                          "msg": myController.text,
                          "sender": widget.uid,
                          "time": DateTime.now()
                        });
                        myController.clear();

                        //Implement send functionality.
                      },
                      child: Text(
                        'Send',
                        style: TextStyle(
                          color: Colors.lightBlueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Align sending(name) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Material(
          elevation: 5,
          color: Colors.blue[300],
          borderRadius: BorderRadius.circular(30),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
            child: Text(
              name,
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Align recieving(name) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Material(
          elevation: 5,
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(30),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
            child: Text(
              name,
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
