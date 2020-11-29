import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
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
                    sending("sent message"),
                    recieving("receved message"),
                    sending("sent message"),
                    recieving("receved message"),
                    sending("sent message"),
                    recieving("receved message"),
                    sending("sent message"),
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
                          //Do something with the user input.
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
                      onPressed: () {
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
