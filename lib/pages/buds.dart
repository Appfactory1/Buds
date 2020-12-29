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
  String uname;
  String field;
  var value;

  Buds(index, bud, uid, uemail, rej, liked, uname, field, value) {
    this.index = index;
    this.bud = bud;
    this.uid = uid;
    this.uemail = uemail;
    this.rej = rej;
    this.liked = liked;
    this.uname = uname;
    this.field = field;
    this.value = value;
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
        Api('users').getDocumentById(uid).then((value1) {
          if (value1.data['reject'] != null) rejects = value1.data['reject'];
          if (value1.data['liked'] != null) {
            liked = value1.data['liked'];
          }
          Authentication().auth.currentUser().then((value2) {
            uemail = value2.email;
            Api('users').getDataCollection().then((value) {
              if (value.documents[widget.index]['uid'] == uid) {
                if (widget.bud.data.documents.length > widget.index + 1) {
                  Future(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Buds(
                                widget.index + 1,
                                null,
                                "",
                                "",
                                [],
                                [],
                                widget.uname,
                                widget.field,
                                widget.value)));
                  });
                }
              }
              if (rejects.contains(value.documents[widget.index]['email']) ||
                  liked.contains(value.documents[widget.index]['email'])) {
                print('yeehaw');
                if (widget.bud.data.documents.length > widget.index + 1) {
                  Future(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Buds(
                                widget.index + 1,
                                widget.bud,
                                uid,
                                uemail,
                                rejects,
                                liked,
                                widget.uname,
                                widget.field,
                                widget.value)));
                  });
                } else {
                  print('ah shit');
                }
              } else {
                if (value.documents[widget.index]['reject'].contains(uemail)) {
                  print('yeehaw');
                  if (widget.bud.data.documents.length > widget.index + 1) {
                    Future(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Buds(
                                  widget.index + 1,
                                  widget.bud,
                                  uid,
                                  uemail,
                                  rejects,
                                  liked,
                                  widget.uname,
                                  widget.field,
                                  widget.value)));
                    });
                  } else {
                    print('ah shit');
                  }
                }
              }
            });
          });
        });
      });
      // if (true) { if (widget.bud.data.documents.length > widget.index + 1) {
      //     Future(() {
      //       Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //               builder: (context) => Buds(
      //                   widget.index + 1,
      //                   widget.bud,
      //                   uid,
      //                   uemail,
      //                   rejects,
      //                   liked,
      //                   widget.uname,
      //                   widget.field,
      //                   widget.value)));
      //     });

    } else {
      if (widget.bud.data.documents['uid'] == widget.uid) {
        if (widget.bud.data.documents.length > widget.index + 1) {
          Future(() {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Buds(
                        widget.index + 1,
                        widget.bud,
                        uid,
                        uemail,
                        rejects,
                        liked,
                        widget.uname,
                        widget.field,
                        widget.value)));
          });
        }
      }
      if (rejects.contains(widget.bud.data.documents[widget.index]['email']) ||
          liked.contains(widget.bud.data.documents[widget.index]['email'])) {
        print('yeehaw');
        if (widget.bud.data.documents.length > widget.index + 1) {
          Future(() {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Buds(
                        widget.index + 1,
                        widget.bud,
                        uid,
                        uemail,
                        rejects,
                        liked,
                        widget.uname,
                        widget.field,
                        widget.value)));
          });
        } else {
          print('ah shit');
        }
      } else {
        if (widget.bud.data.documents[widget.index]['email'].contains(uemail)) {
          print('yeehaw');
          if (widget.bud.data.documents.length > widget.index + 1) {
            Future(() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Buds(
                          widget.index + 1,
                          widget.bud,
                          uid,
                          uemail,
                          rejects,
                          liked,
                          widget.uname,
                          widget.field,
                          widget.value)));
            });
          } else {
            print('ah shit');
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AllChats(uid, widget.uemail, widget.uname)));
              },
              iconSize: 40,
            )
          ],
        ),
        body: bud == null
            ? StreamBuilder(
                stream: widget.value == 'interest'
                    ? Api('users').streamDataCollectionForInterest(
                        widget.field, widget.value)
                    : Api('users').streamDataCollectionWithWhere(
                        widget.field, widget.value),
                builder: (context, snapshot) {
                  print(snapshot.data.documents[index]['email'] + ' mc');
                  print(snapshot.data.documents[index]['url'] == null);
                  if (snapshot.data.documents.length > 0) {
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
                              child: snapshot.data.documents[index]['url'] ==
                                      null
                                  ? Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      height: 400,
                                      width: double.infinity,
                                    )
                                  : PageView.builder(
                                      itemCount: snapshot
                                          .data.documents[index]['url'].length,
                                      itemBuilder:
                                          (BuildContext context, int index1) {
                                        print("anything123");
                                        return Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            height: 400,
                                            width: double.infinity,
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  snapshot.data.documents[index]
                                                      ['url'][index1],
                                              fit: BoxFit.cover,
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ));
                                      })),
                          SizedBox(height: 25),
                          Text(
                            snapshot.data.documents[index]['email'],
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 20),
                          ),
                          Text(
                            snapshot.data.documents[index]['designation'] ==
                                    null
                                ? ''
                                : snapshot.data.documents[index]['designation'],
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 20),
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
                                  if (!rejects.contains(snapshot
                                      .data.documents[index]['email'])) {
                                    rejects.add(snapshot.data.documents[index]
                                        ['email']);
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
                                                liked,
                                                widget.uname,
                                                widget.field,
                                                widget.value)));
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
                                  Firestore.instance
                                      .collection('chats')
                                      .where("users", whereIn: [
                                        uid +
                                            snapshot.data.documents[index]
                                                ['uid']
                                      ])
                                      .getDocuments()
                                      .then((value) {
                                        if (value.documents.length == 0)
                                          Api("chats").addDocument({
                                            "users": uid +
                                                snapshot.data.documents[index]
                                                    ['uid'],
                                            "usernames": [
                                              (snapshot.data.documents[index]
                                                              ['uname'] ==
                                                          null &&
                                                      snapshot.data.documents[
                                                              index]['uname'] ==
                                                          null)
                                                  ? snapshot.data
                                                      .documents[index]['email']
                                                  : snapshot
                                                          .data.documents[index]
                                                      ['uname'],
                                              widget.uname
                                            ]
                                          });
                                      });
                                  liked.add(
                                      snapshot.data.documents[index]['email']);
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
                                                liked,
                                                widget.uname,
                                                widget.field,
                                                widget.value)));
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
                  } else {
                    return Center(
                      child: Text('No Data'),
                    );
                  }
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
                                itemBuilder:
                                    (BuildContext context, int index1) {
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
                                            ['url'][index1],
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
                          : bud.data.documents[index]['designation'],
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
                                      builder: (context) => Buds(
                                          index + 1,
                                          bud,
                                          uid,
                                          uemail,
                                          rejects,
                                          liked,
                                          widget.uname,
                                          widget.field,
                                          widget.value)));
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
                            Firestore.instance
                                .collection('chats')
                                .where("users", whereIn: [
                                  uid + bud.data.documents[0]['uid']
                                ])
                                .getDocuments()
                                .then((value) {
                                  Api("chats").addDocument({
                                    "users": uid + bud.data.documents[0]['uid'],
                                    "usernames": [
                                      (bud.data.documents[index]['uname'] ==
                                                  null &&
                                              bud.data.documents[index]
                                                      ['uname'] ==
                                                  null)
                                          ? bud.data.documents[index]['email']
                                          : bud.data.documents[index]['uname'],
                                      widget.uname
                                    ]
                                  });
                                });
                            liked.add(bud.data.documents[index]['email']);
                            Api('users')
                                .updateDocument({'reject': rejects}, uid);
                            if (bud.data.documents.length > index + 1) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Buds(
                                          index + 1,
                                          bud,
                                          uid,
                                          uemail,
                                          rejects,
                                          liked,
                                          widget.uname,
                                          widget.field,
                                          widget.value)));
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
                                    builder: (context) => AllChats(
                                        uid, widget.uemail, widget.uname)));
                          },
                          iconSize: 55,
                          color: Colors.grey,
                        ))
                  ],
                ),
              ));
  }
}
