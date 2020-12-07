import 'package:chat_app/firebase/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  String uid;
  String msg;

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.currentUser().then((value) => uid = value.uid);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
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
                        stream: Api("chats/onechat/text")
                            .streamDataCollectionordered(),
                        builder: (BuildContext context, snapshot) {
                          return Expanded(
                            child: ListView.builder(
                              physics: AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (BuildContext context, int index) {
                                return (snapshot.data.documents[index]
                                            ['sender'] ==
                                        uid)
                                    ? sending(
                                        snapshot.data.documents[index]['msg'])
                                    : recieving(
                                        snapshot.data.documents[index]['msg']);
                              },
                            ),
                          );
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
                        Api("chats/" + "onechat" + "/text").addDocument({
                          "msg": msg,
                          "sender": uid,
                          "time": DateTime.now()
                        });
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
