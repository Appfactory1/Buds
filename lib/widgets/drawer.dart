import 'package:chat_app/firebase/auth.dart';
import 'package:chat_app/firebase/firestore.dart';
import 'package:chat_app/pages/account_settings.dart';
import 'package:chat_app/pages/all_chats.dart';
import 'package:chat_app/pages/home.dart';
import 'package:chat_app/pages/interest.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String email = '';
  String username = '';
  String univesity = '';
  String country = '';
  String occupation = '';
  String uid;
  @override
  void initState() {
    Authentication().getUid().then((value) {
      uid = value;
      Api('users').getDocumentById(uid).then((value1) {
        setState(() {
          email = value1.data['email'];
          univesity = value1.data['university'] == null
              ? ''
              : value1.data['university'];
          country =
              value1.data['country'] == null ? '' : value1.data['country'];
          username = value1.data['uname'] == null ? '' : value1.data['uname'];
          occupation =
              value1.data['workPlace'] == null ? '' : value1.data['workPlace'];
        });
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
              accountName: Text(username == "" ? "User" : username),
              accountEmail: Text(email == "" ? '' : email)),
          ListTile(
            title: Text("Home"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()));
            },
          ),
          Divider(
            color: Colors.black,
            height: 4.0,
          ),
          ListTile(
            title: Text("Interests"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Interest()));
            },
          ),
          Divider(
            color: Colors.black,
            height: 4.0,
          ),
          ListTile(
            title: Text("Account Settings"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AccountSettings(
                          univesity, country, occupation, username)));
            },
          ),
          Divider(
            color: Colors.black,
            height: 4.0,
          ),
          ListTile(
            title: Text("Chats"),
            onTap: () {
              if (!(username == "" && email == "")) {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AllChats(uid, email, username)));
              }
            },
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 55),
            child: Container(
              height: 50,
              //decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.deepPurple[900],
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => Buds(null, null)));
                  Authentication().logOut();
                },
                child: Text(
                  "Sign Out",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
