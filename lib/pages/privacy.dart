import 'package:chat_app/pages/account_settings.dart';
import 'package:flutter/material.dart';

class Privacy extends StatefulWidget {
  @override
  _PrivacyState createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  bool ans = true;
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
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(children: [
          SizedBox(height: 10),
          Center(
            child: Text(
              "Privacy Settings",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 28,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Rows1(
            name: "Update Password",
            icon: Icons.lock,
          ),
          Rows1(
            name: "Add Phone Number",
            icon: Icons.phone,
          ),
          Rows1(name: "Education", icon: Icons.school_rounded),
          Padding(
            padding: EdgeInsets.only(left: 52),
            child: Column(
              children: [
                buildRow("Work"),
                buildRow("Country"),
                buildRow("Distance"),
              ],
            ),
          ),
          Rows1(
            name: "Work",
            icon: Icons.work,
          ),
          Padding(
            padding: EdgeInsets.only(left: 52),
            child: Column(
              children: [
                buildRow("Work"),
                buildRow("Country"),
                buildRow("Distance"),
              ],
            ),
          ),
          Rows1(name: "Interest", icon: Icons.favorite),
          Padding(
            padding: EdgeInsets.only(left: 52),
            child: Column(
              children: [
                buildRow("Work"),
                buildRow("Country"),
                buildRow("Distance"),
              ],
            ),
          )
        ]),
      ),
    );
  }

  Row buildRow(name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18,
            )),
        Switch(
            value: ans,
            onChanged: (val) {
              setState(() {
                ans = val;
              });
            })
      ],
    );
  }
}
