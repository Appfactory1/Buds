import 'package:chat_app/pages/bud_friend.dart';
import 'package:flutter/material.dart';

class Buds extends StatefulWidget {
  @override
  _BudsState createState() => _BudsState();
}

class _BudsState extends State<Buds> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.grey),
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              icon: Icon(Icons.mail),
              onPressed: null,
              iconSize: 40,
            )
          ],
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
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
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
                  SizedBox(
                    width: 20,
                  ),
                  Container(
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
                  )
                ],
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(Icons.settings_outlined),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => BudFriend()));
                    },
                    iconSize: 55,
                    color: Colors.grey,
                  ))
            ],
          ),
        ));
  }
}
