import 'dart:ui';

import 'package:chat_app/firebase/auth.dart';
import 'package:chat_app/firebase/firestore.dart';
import 'package:chat_app/firebase/storage.dart';
import 'package:chat_app/pages/bud_friend.dart';
import 'package:chat_app/pages/contriesList.dart';
import 'package:chat_app/pages/home.dart';
import 'package:chat_app/pages/occupations.dart';
import 'package:chat_app/pages/universitiesList.dart';
import 'package:chat_app/widgets/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:dropdownfield/dropdownfield.dart';

class AccountSettings extends StatefulWidget {
  String uni_id;
  String cou_id;
  String occ_id;
  String username;

  AccountSettings(uni_id, cou_id, occ_id, username) {
    this.uni_id = uni_id;
    this.cou_id = cou_id;
    this.occ_id = occ_id;
    this.username = username;
  }

  @override
  _AccountSettingsState createState() => new _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  List images = List();
  List nimages = [];
  List newurls;
  List<Asset> newimages = List<Asset>();

  String _error = 'No Error Dectected';

  TextEditingController uname;
  TextEditingController batch;
  TextEditingController program;
  TextEditingController workPlace;
  TextEditingController designation;
  TextEditingController city;
  TextEditingController country;

  String uid;
  int temp = 0;
  List urls = [];

  List<String> univesities = unis;
  List<String> countries = coun;
  List<String> occupations = occ;
  final TextEditingController _controller = new TextEditingController();

  DocumentSnapshot snap;

  @override
  void initState() {
    Authentication().getUid().then((value) {
      uid = value;
      Api('users').getDocumentById(uid).then((val) {
        setState(() {
          snap = val;
          snap != null
              ? snap.data['url'] == null
                  ? images = []
                  : setState(() {
                      images = snap.data['url'];
                    })
              : images = [];
          uname = TextEditingController(
              text: snap != null
                  ? snap.data['uname'] == null
                      ? ''
                      : snap.data['uname']
                  : '');
          // university = TextEditingController(
          //     text: snap != null
          //         ? snap.data['university'] == null
          //             ? ''
          //             : snap.data['university']
          //         : '');
          // university_id = snap != null
          //     ? snap.data['university'] == null
          //         ? ''
          //         : snap.data['university']
          //     : '';
          // print(university_id);
          // university_id =
          //     "National University of Sciences and Technology (Pakistan)";
          batch = TextEditingController(
              text: snap != null
                  ? snap.data['batch'] == null
                      ? ''
                      : snap.data['batch']
                  : '');
          program = TextEditingController(
              text: snap != null
                  ? snap.data['program'] == null
                      ? ''
                      : snap.data['program']
                  : '');
          workPlace = TextEditingController(
              text: snap != null
                  ? snap.data['workPlace'] == null
                      ? ''
                      : snap.data['workPlace']
                  : '');
          designation = TextEditingController(
              text: snap != null
                  ? snap.data['designation'] == null
                      ? ''
                      : snap.data['designation']
                  : '');
          country = TextEditingController(
              text: snap != null
                  ? snap.data['country'] == null
                      ? ''
                      : snap.data['country']
                  : '');
          city = TextEditingController(
              text: snap != null
                  ? snap.data['city'] == null
                      ? ''
                      : snap.data['city']
                  : '');
          snap != null
              ? snap.data['url'] == null
                  ? urls = []
                  : urls = snap.data['url']
              : urls = [];
        });
      });
    });
    super.initState();
  }

  TextEditingController university;

  Widget buildGridView() {
    return ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 160),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: images.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              var asset = images[index];
              return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: Stack(children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: asset is String
                            ? Image.network(asset)
                            : AssetThumb(
                                //asset: asset,
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
                            if (asset is String) {
                              print(urls[index]);
                              urls.removeAt(index);
                              print(urls);
                            }
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
    List resultList = List();
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
    String university_id = widget.uni_id;
    String country_id = widget.cou_id;
    String occupation_id = widget.occ_id;
    print(university_id);
    return new MaterialApp(
      home: new Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          toolbarHeight: 70,
          backgroundColor: Colors.deepPurple[900],
        ),
        drawer: MyDrawer(),
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
            Rows1(name: "User Name", icon: Icons.school_rounded),
            Padding(
                padding: EdgeInsets.only(left: 52),
                child: Column(children: [
                  Row(
                    children: [
                      Text("Username",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          )),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(right: 8.0, left: 37),
                        child: widget.username != ""
                            ? Text(widget.username,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ))
                            : TextField(
                                controller: uname,
                                decoration: InputDecoration(),
                                selectionHeightStyle:
                                    BoxHeightStyle.includeLineSpacingMiddle,
                                // onSubmitted: (value) {
                                //   //setState(() {});
                                // },

                                // onChanged: (value) {
                                //   print(value);
                                //   university = value;
                                // },
                              ),
                      ))
                    ],
                  ),
                ])),
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
                        child: DropDownField(
                          onValueChanged: (dynamic value) {
                            university_id = value;
                          },
                          value: university_id,
                          itemsVisibleInDropdown: 5,
                          required: false,
                          hintText: 'Choose a university',
                          labelText: 'University',
                          items: univesities,
                        ),
                        // TextField(
                        //   controller: university,
                        //   decoration: InputDecoration(),
                        //   selectionHeightStyle:
                        //       BoxHeightStyle.includeLineSpacingMiddle,
                        // onSubmitted: (value) {
                        //   //setState(() {});
                        // },

                        // onChanged: (value) {
                        //   print(value);
                        //   university = value;
                        // },
                        // ),
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
                          controller: batch,
                          selectionHeightStyle:
                              BoxHeightStyle.includeLineSpacingMiddle,
                          onSubmitted: (value) {
                            //setState(() {});
                          },
                          onChanged: (value) {
                            //print(uname.text);
                          },
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
                          controller: program,
                          selectionHeightStyle:
                              BoxHeightStyle.includeLineSpacingMiddle,
                          onSubmitted: (value) {
                            // setState(() {});
                          },
                          // onChanged: (value) {
                          //   program = value;
                          // },
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
                        child: DropDownField(
                          onValueChanged: (dynamic value) {
                            occupation_id = value;
                          },
                          value: occupation_id,
                          itemsVisibleInDropdown: 5,
                          required: false,
                          hintText: 'Choose an Occupation',
                          labelText: 'Occupation',
                          items: occupations,
                        ),
                      ))
                    ],
                  ),
                  Row(
                    children: [
                      Text("Designation",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          )),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(right: 8.0, left: 27),
                        child: TextField(
                          controller: designation,
                          selectionHeightStyle:
                              BoxHeightStyle.includeLineSpacingMiddle,
                          onSubmitted: (value) {
                            //setState(() {});
                          },
                          // onChanged: (value) {
                          //   designation = value;
                          // },
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
                        child: DropDownField(
                          onValueChanged: (dynamic value) {
                            country_id = value;
                          },
                          value: country_id,
                          itemsVisibleInDropdown: 5,
                          required: false,
                          hintText: 'Choose a Country',
                          labelText: 'Country',
                          items: countries,
                        ),
                        // TextField(
                        //   controller: country,
                        //   selectionHeightStyle:
                        //       BoxHeightStyle.includeLineSpacingMiddle,
                        //   onSubmitted: (value) {
                        //     //setState(() {});
                        //   },
                        //   // onChanged: (value) {
                        //   //   country = value;
                        //   // },
                        // ),
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
                          controller: city,
                          selectionHeightStyle:
                              BoxHeightStyle.includeLineSpacingMiddle,
                          onSubmitted: (value) {
                            //setState(() {});
                          },
                          // onChanged: (value) {
                          //   city = value;
                          // },
                        ),
                      ))
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 55),
              child: Container(
                height: 50,
                //decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.deepPurple[900],
                  onPressed: () async {
                    nimages = images.map((e) {
                      if (e is String) {
                      } else {
                        return e;
                      }
                    }).toList();
                    nimages.removeWhere((e) => e == null);

                    if (nimages == null) {
                    } else {
                      newurls = await addimages(nimages);
                      urls.addAll(newurls);
                    }
                    print(urls);
                    Api("users").updateDocument({
                      "uname":
                          widget.username == "" ? uname.text : widget.username,
                      "university": university_id,
                      "batch": batch.text,
                      "program": program.text,
                      "workPlace": occupation_id,
                      "designation": designation.text,
                      "country": country_id,
                      "city": city.text,
                      'url': urls
                    }, uid).then((value) {
                      print("bhen ka lora");
                      Navigator.of(context).pop();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home()));

                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => BudFriend()));
                    });
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  Future<List<String>> addimages(imgs) async {
    List<String> url = [];
    for (int i = 0; i < imgs.length; i++) {
      String uuid = Uuid().v4();
      url.add(await StorageApi(path: "images/$uuid")
          .addImage((await imgs[i].getByteData()).buffer.asUint8List()));
    }

    return url;
  }
}

class Rows1 extends StatelessWidget {
  final String name;
  final IconData icon;
  final TextEditingController controller;
  const Rows1({
    this.name,
    this.icon,
    this.controller,
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
