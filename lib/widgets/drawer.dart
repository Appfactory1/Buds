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
  String uid;
  @override
  void initState() {
    Authentication().getUid().then((value) {
      uid = value;
    });
    Api('users').getDocumentById(uid).then((value) {
      email = value.data['email'];
      username = value.data['uname'];
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AccountSettings()));
            },
          ),
          Divider(
            color: Colors.black,
            height: 4.0,
          ),
          ListTile(
            title: Text("Chats"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AllChats(uid, email, username)));
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
