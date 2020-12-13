import 'package:chat_app/firebase/auth.dart';
import 'package:chat_app/firebase/firestore.dart';
import 'package:chat_app/pages/buds.dart';
import 'package:chat_app/pages/login.dart';
import 'package:flutter/material.dart';

class Interest extends StatefulWidget {
  @override
  _InterestState createState() => _InterestState();
}

class _InterestState extends State<Interest> {
  List interests = [];
  String uid;

  @override
  void initState() {
    Authentication().getUid().then((value) {
      uid = value;
      Api('users').getDocumentById(value).then((value) {
        if (value.data['interest'] != null) {
          setState(() {
            interests = value.data['interest'];
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String interest;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: Colors.deepPurple[900],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: ListView(
            children: [
              ListView(shrinkWrap: true, children: [
                SizedBox(height: 40),
                Text(
                  "Search Interest",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 28,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.grey[300]),
                  child: TextField(
                    onSubmitted: (value) {
                      setState(() {
                        interests.add(value);
                      });
                      print(interests);
                    },
                    // onFieldSubmitted: (value) {
                    //   setState(() {
                    //     interests.add(value);
                    //   });
                    // },
                    onChanged: (value) => interest = value,
                    decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: interests.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 4.5),
                      itemBuilder: (BuildContext context, int index) {
                        return _interest(interests[index], index);
                      }),
                )
              ]),
              SizedBox(height: 20),
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
                      Api('users').updateDocument({'interest': interests}, uid);
                    },
                    child: Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Widget _interest(String name, int index) {
    return Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(18)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  name,
                  style: TextStyle(color: Colors.grey[600]),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            IconButton(
                padding: EdgeInsets.only(bottom: 2, top: 2, right: 0),
                splashColor: Colors.transparent,
                color: Colors.grey[600],
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    interests.removeAt(index);
                  });
                }),
          ],
        ));
  }
}
