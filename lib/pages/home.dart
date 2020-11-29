import 'package:chat_app/pages/interest.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.grey, //change your color here
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        body: ListView(
          children: [
            SizedBox(height: 160),
            Center(
                child: Text(
              "Let's Search Your Buds",
              style: TextStyle(color: Colors.grey, fontSize: 25),
            )),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                //crossAxisAlignment: ,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BudCat(name: "Native Buddies"),
                      BudCat(name: "Work Buddies")
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BudCat(name: "Uni/College Buddies"),
                      BudCat(name: "Uni/College Buddies")
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }
}

class BudCat extends StatelessWidget {
  final String name;
  const BudCat({
    this.name,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Interest()));
      },
      child: Column(children: [
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80), color: Colors.grey[350]),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          name,
          style: TextStyle(color: Colors.grey, fontSize: 12),
        )
      ]),
    );
  }
}
