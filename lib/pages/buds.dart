import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/firebase/auth.dart';
import 'package:chat_app/firebase/firestore.dart';
import 'package:chat_app/pages/all_chats.dart';
import 'package:chat_app/pages/bud_friend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Buds extends StatefulWidget {
  int index;
  AsyncSnapshot bud;
  String uid;
  String uemail;
  List rej;
  List liked;

  Buds(index, bud, uid, uemail, rej, liked) {
    this.index = index;
    this.bud = bud;
    this.uid = uid;
    this.uemail = uemail;
    this.rej = rej;
    this.liked = liked;
  }

  @override
  _BudsState createState() => _BudsState();
}

class _BudsState extends State<Buds> {
  final Firestore tempfb = Firestore.instance;

  int index;
  AsyncSnapshot bud;
  final snackBar = SnackBar(content: Text('No more'));
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  DocumentSnapshot snapshot;
  List rejects = [];
  List liked = [];
  String uid;
  String uemail;

  void initState() {
    print("something" + widget.uid);
    uid = widget.uid;
    uemail = widget.uemail;
    rejects = widget.rej;
    liked = widget.liked;

    if (uid == "") {
      Authentication().getUid().then((value) {
        uid = value;
        Api('users').getDocumentById(uid).then((value) {
          if (value.data['reject'] != null) {
            rejects = value.data['reject'];
            Authentication().auth.currentUser().then((value) {
              uemail = value.email;
              if (rejects
                  .contains(widget.bud.data.documents[widget.index]['email'])) {
                print('yeehaw');
                if (widget.bud.data.documents.length > widget.index + 1) {
                  Future(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Buds(widget.index + 1,
                                widget.bud, uid, uemail, rejects, liked)));
                  });
                } else {
                  print('ah shit');
                  //_scaffoldKey.currentState.showSnackBar(snackBar);
                }
              } else {
                if (widget.bud.data.documents[widget.index]['email']
                    .contains(uemail)) {
                  print('yeehaw');
                  if (widget.bud.data.documents.length > widget.index + 1) {
                    Future(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Buds(widget.index + 1,
                                  widget.bud, uid, uemail, rejects, liked)));
                    });
                  } else {
                    print('ah shit');
                    //_scaffoldKey.currentState.showSnackBar(snackBar);
                  }
                }
              }
            });
          }
        });
        Api('users').getDocumentById(uid).then((value) {
          if (value.data['liked'] != null) {
            liked = value.data['liked'];
          }
        });
      });
    } else {
      // Api('users').getDocumentById(uid).then((value) => {
      //       if (value.data['rejects'] != null) {rejects = value.data['rejects']}
      //     });
      //       if (value.data['rejects'] != null) {rejects = value.data['rejects']}
      //     });
      if (rejects.contains(widget.bud.data.documents[widget.index]['email'])) {
        print('yeehaw');
        if (widget.bud.data.documents.length > widget.index + 1) {
          Future(() {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Buds(widget.index + 1, widget.bud,
                        uid, uemail, rejects, liked)));
          });
        } else {
          print('ah shit');
          //_scaffoldKey.currentState.showSnackBar(snackBar);
        }
      } else {
        if (widget.bud.data.documents[widget.index]['email'].contains(uemail)) {
          print('yeehaw');
          if (widget.bud.data.documents.length > widget.index + 1) {
            Future(() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Buds(widget.index + 1, widget.bud,
                          uid, uemail, rejects, liked)));
            });
          } else {
            print('ah shit');
            //_scaffoldKey.currentState.showSnackBar(snackBar);
          }
        }
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    index = widget.index == null ? 0 : widget.index;
    bud = widget.bud == null ? null : widget.bud;

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.grey),
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              icon: Icon(Icons.mail),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AllChats(uid)));
              },
              iconSize: 40,
            )
          ],
        ),
        body: bud == null
            ? StreamBuilder(
                stream: Api('users').streamDataCollection(),
                builder: (context, snapshot) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 400,
                          child: PageView.builder(
                              itemCount:
                                  snapshot.data.documents[0]['url'].length,
                              itemBuilder: (BuildContext context, int index) {
                                print("Bitch?");
                                return Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    height: 400,
                                    width: double.infinity,
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot.data.documents[0]
                                          ['url'][index],
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ));
                              }),
                        ),
                        SizedBox(height: 25),
                        Text(
                          snapshot.data.documents[0]['email'],
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 20),
                        ),
                        Text(
                          snapshot.data.documents[0]['designation'],
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 20),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              // reject
                              onTap: () {
                                if (!rejects.contains(
                                    snapshot.data.documents[0]['email'])) {
                                  rejects
                                      .add(snapshot.data.documents[0]['email']);
                                }
                                Api('users')
                                    .updateDocument({'reject': rejects}, uid);
                                if (snapshot.data.documents.length >
                                    index + 1) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Buds(
                                              index + 1,
                                              snapshot,
                                              uid,
                                              uemail,
                                              rejects,
                                              liked)));
                                }
                              },
                              child: Container(
                                height: 55,
                                width: 55,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(60)),
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.orange,
                                  size: 45,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                              // accept
                              onTap: () async {
                                Api("chats").addDocument({
                                  "users": uid + "vbD9HHSnwzO8A81g8Dht",
                                });
                                liked.add(snapshot.data.documents[0]['email']);
                                Api('users')
                                    .updateDocument({'liked': liked}, uid);
                                if (snapshot.data.documents.length >
                                    index + 1) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Buds(
                                              index + 1,
                                              snapshot,
                                              uid,
                                              uemail,
                                              rejects,
                                              liked)));
                                }
                              },
                              child: Container(
                                height: 55,
                                width: 55,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(60)),
                                child: Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 45,
                                ),
                              ),
                            )
                          ],
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              icon: Icon(Icons.settings_outlined),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BudFriend()));
                              },
                              iconSize: 55,
                              color: Colors.grey,
                            ))
                      ],
                    ),
                  );
                })
            : //when data is passed from arguement
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        height: 400,
                        child: bud.data.documents[index]['url'] == null
                            ? Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(25)),
                                height: 400,
                                width: double.infinity,
                              )
                            : PageView.builder(
                                itemCount:
                                    bud.data.documents[index]['url'].length,
                                itemBuilder: (BuildContext context, int index) {
                                  print("anything123");
                                  return Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      height: 400,
                                      width: double.infinity,
                                      child: CachedNetworkImage(
                                        imageUrl: bud.data.documents[index]
                                            ['url'][index],
                                        fit: BoxFit.cover,
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ));
                                })),
                    SizedBox(height: 25),
                    Text(
                      bud.data.documents[index]['email'] == null
                          ? ""
                          : bud.data.documents[index]['email'],
                      style: TextStyle(color: Colors.grey[600], fontSize: 20),
                    ),
                    Text(
                      bud.data.documents[index]['designation'] == null
                          ? ""
                          : bud.data.documents[index]['email'],
                      style: TextStyle(color: Colors.grey[600], fontSize: 20),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          // reject
                          onTap: () {
                            if (rejects.contains(widget
                                .bud.data.documents[widget.index]['email'])) {
                              rejects.add(bud.data.documents[index]['email']);
                            }
                            Api('users')
                                .updateDocument({'reject': rejects}, uid);
                            if (bud.data.documents.length > index + 1) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Buds(index + 1, bud,
                                          uid, uemail, rejects, liked)));
                            }
                          },
                          child: Container(
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(60)),
                            child: Icon(
                              Icons.clear,
                              color: Colors.orange,
                              size: 45,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          // accept
                          onTap: () async {
                            Api("chats").addDocument({
                              "users": uid + "vbD9HHSnwzO8A81g8Dht",
                            });
                            liked.add(bud.data.documents[index]['email']);
                            Api('users')
                                .updateDocument({'reject': rejects}, uid);
                            if (bud.data.documents.length > index + 1) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Buds(index + 1, bud,
                                          uid, uemail, rejects, liked)));
                            } else {
                              _scaffoldKey.currentState.showSnackBar(snackBar);
                            }
                          },
                          child: Container(
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(60)),
                            child: Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 45,
                            ),
                          ),
                        )
                      ],
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          icon: Icon(Icons.settings_outlined),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AllChats(uid)));
                          },
                          iconSize: 55,
                          color: Colors.grey,
                        ))
                  ],
                ),
              ));
  }
}
