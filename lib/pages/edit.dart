import 'package:chat_app/pages/account_settings.dart';
import 'package:chat_app/pages/privacy.dart';
import 'package:flutter/material.dart';

class Edit extends StatefulWidget {
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  @override
  void initState() {
    super.initState();
  }

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
            child: ListView(physics: NeverScrollableScrollPhysics(), children: [
              SizedBox(
                height: 100,
              ),
              Center(
                child: Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(80)),
                  child: Icon(
                    Icons.photo_camera,
                    color: Colors.grey[500],
                    size: 55,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              // GestureDetector(
              //     onTap: () {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => AccountSettings()));
              //     },
              // child: Rows(
              //     name: "Profile Setting", icon: Icons.settings_outlined)),
              GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Privacy()));
                  },
                  child: Rows(name: "Privacy Setting", icon: Icons.clear)),
              GestureDetector(child: Rows(name: "Help", icon: Icons.help)),
              GestureDetector(child: Rows(name: "Logout", icon: Icons.logout))
            ])));
  }
}

class Rows extends StatelessWidget {
  final String name;
  final IconData icon;
  const Rows({
    this.name,
    this.icon,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          icon: Icon(icon),
          onPressed: () {},
          iconSize: 35,
          color: Colors.grey,
          splashColor: Colors.transparent,
        ),
        SizedBox(
          width: 10,
        ),
        Text(name, style: TextStyle(color: Colors.grey, fontSize: 22)),
      ],
    );
  }
}
