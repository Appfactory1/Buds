import 'package:chat_app/pages/chat.dart';
import 'package:chat_app/pages/edit.dart';
import 'package:flutter/material.dart';

class BudFriend extends StatefulWidget {
  @override
  _BudFriendState createState() => _BudFriendState();
}

class _BudFriendState extends State<BudFriend> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.grey),
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(25)),
                height: 400,
                width: double.infinity,
                child: PageView(),
              ),
              SizedBox(height: 25),
              Text(
                "Name",
                style: TextStyle(color: Colors.grey[600], fontSize: 20),
              ),
              Text(
                "Work/Education",
                style: TextStyle(color: Colors.grey[600], fontSize: 20),
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Edit()));
                    },
                    icon: Icon(Icons.settings_outlined),
                    iconSize: 60,
                    color: Colors.grey,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Chat()));
                    },
                    icon: Icon(Icons.mail),
                    iconSize: 60,
                    color: Colors.grey,
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
