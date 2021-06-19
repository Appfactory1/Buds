import 'package:chat_app/pages/universitiesList.dart';
import 'package:flutter/material.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Extra extends StatefulWidget {
  @override
  _ExtraState createState() => _ExtraState();
}

class _ExtraState extends State<Extra> {
  final colorizeColors = [
    Colors.purple,
    Colors.purple.shade100,
    Colors.purple.shade200,
    Colors.purple.shade300,
    Colors.purple.shade400,
    Colors.purple.shade500,
    Colors.purple.shade600,
    Colors.purple.shade700,
    Colors.purple.shade800,
    Colors.purple.shade900,
  ];
  final colorizeTextStyle = TextStyle(
    fontSize: 30.0,
    fontFamily: 'Horizon',
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    String country_id;
    List<String> countries = unis;
    final TextEditingController _controller = new TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Animation"),
      ),
      body: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              const Text(
                'Welcome to ',
                style: TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'Horizon',
                ),
              ),
              AnimatedTextKit(animatedTexts: [
                ColorizeAnimatedText(
                  'Buds',
                  textStyle: colorizeTextStyle,
                  colors: colorizeColors,
                  speed: Duration(milliseconds: 200),
                ),
              ]),
            ],
          )),
    );
  }
}
