import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:multi_image_picker/multi_image_picker.dart';

class AccountSettings extends StatefulWidget {
  @override
  _AccountSettingsState createState() => new _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  List<Asset> images = List<Asset>();
  List<Asset> newimages = List<Asset>();
  String _error = 'No Error Dectected';

  @override
  void initState() {
    super.initState();
  }

  Widget buildGridView() {
    return ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 160),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: images.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              Asset asset = images[index];
              return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: Stack(children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: AssetThumb(
                          asset: asset,
                          width: 100,
                          height: 150,
                        )),
                    Positioned(
                      top: 5,
                      right: 5,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            images.removeAt(index);
                          });
                        },
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100)),
                          child: Icon(
                            Icons.clear,
                            color: Colors.black,
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                  ]));
            }));
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 8,
        enableCamera: true,
        selectedAssets: newimages,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Pictures",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      newimages = resultList;
      images.addAll(newimages);
      _error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          toolbarHeight: 70,
          backgroundColor: Colors.deepPurple[900],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(shrinkWrap: true, children: [
            SizedBox(height: 5),
            Center(
              child: Text(
                "Account Settings",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 28,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 15),
            Text(
              "Upload Picture",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            Row(
              // shrinkWrap: true,
              // scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 6.0),
                  child: GestureDetector(
                    child: Container(
                      height: 75,
                      width: 75,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(100)),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 70,
                      ),
                    ),
                    onTap: loadAssets,
                  ),
                ),
                Expanded(
                  child: buildGridView(),
                ),
              ],
            ),
            Rows1(name: "Education", icon: Icons.school_rounded),
            Padding(
                padding: EdgeInsets.only(left: 52),
                child: Column(children: [
                  Row(
                    children: [
                      Text("University",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          )),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(right: 8.0, left: 40),
                        child: TextField(
                          selectionHeightStyle:
                              BoxHeightStyle.includeLineSpacingMiddle,
                          onSubmitted: (value) {
                            setState(() {});
                          },
                          onChanged: (value) => () {},
                        ),
                      ))
                    ],
                  ),
                  Row(
                    children: [
                      Text("Batch",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          )),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(right: 8.0, left: 72),
                        child: TextField(
                          selectionHeightStyle:
                              BoxHeightStyle.includeLineSpacingMiddle,
                          onSubmitted: (value) {
                            setState(() {});
                          },
                          onChanged: (value) => () {},
                        ),
                      ))
                    ],
                  ),
                  Row(
                    children: [
                      Text("Program",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          )),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(right: 8.0, left: 50),
                        child: TextField(
                          selectionHeightStyle:
                              BoxHeightStyle.includeLineSpacingMiddle,
                          onSubmitted: (value) {
                            setState(() {});
                          },
                          onChanged: (value) => () {},
                        ),
                      ))
                    ],
                  ),
                ])),
            Rows1(name: "Work", icon: Icons.work_rounded),
            Padding(
                padding: EdgeInsets.only(left: 52),
                child: Column(children: [
                  Row(
                    children: [
                      Text("Work Place",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          )),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(right: 8.0, left: 28),
                        child: TextField(
                          selectionHeightStyle:
                              BoxHeightStyle.includeLineSpacingMiddle,
                          onSubmitted: (value) {
                            setState(() {});
                          },
                          onChanged: (value) => () {},
                        ),
                      ))
                    ],
                  ),
                  Row(
                    children: [
                      Text("Destination",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          )),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(right: 8.0, left: 27),
                        child: TextField(
                          selectionHeightStyle:
                              BoxHeightStyle.includeLineSpacingMiddle,
                          onSubmitted: (value) {
                            setState(() {});
                          },
                          onChanged: (value) => () {},
                        ),
                      ))
                    ],
                  ),
                ])),
            Rows1(name: "Location", icon: Icons.location_city),
            Padding(
              padding: EdgeInsets.only(left: 52),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Country",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          )),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(right: 8.0, left: 54),
                        child: TextField(
                          selectionHeightStyle:
                              BoxHeightStyle.includeLineSpacingMiddle,
                          onSubmitted: (value) {
                            setState(() {});
                          },
                          onChanged: (value) => () {},
                        ),
                      ))
                    ],
                  ),
                  Row(
                    children: [
                      Text("City",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          )),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(right: 8.0, left: 85),
                        child: TextField(
                          selectionHeightStyle:
                              BoxHeightStyle.includeLineSpacingMiddle,
                          onSubmitted: (value) {
                            setState(() {});
                          },
                          onChanged: (value) => () {},
                        ),
                      ))
                    ],
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class Rows1 extends StatelessWidget {
  final String name;
  final IconData icon;
  const Rows1({
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
        Text(name,
            style: TextStyle(
                color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
