import 'package:chat_app/pages/universitiesList.dart';
import 'package:flutter/material.dart';
import 'package:dropdownfield/dropdownfield.dart';

class Extra extends StatefulWidget {
  @override
  _ExtraState createState() => _ExtraState();
}

class _ExtraState extends State<Extra> {
  @override
  Widget build(BuildContext context) {
    String country_id;
    List<String> countries = unis;
    final TextEditingController _controller = new TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Dropdown Form"),
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              DropDownField(
                onValueChanged: (dynamic value) {
                  country_id = value;
                },
                value: country_id,
                itemsVisibleInDropdown: 10,
                required: false,
                hintText: 'Choose a country',
                labelText: 'Country',
                items: countries,
              ),
              FlatButton(
                  color: Colors.red,
                  onPressed: () {
                    print(country_id);
                  },
                  child: Text("something"))
            ]),
      ),
    );
  }
}
