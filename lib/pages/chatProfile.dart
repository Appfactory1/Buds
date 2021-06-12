import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/firebase/auth.dart';
import 'package:chat_app/firebase/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class ProfileChat extends StatefulWidget {
  String uid;

  ProfileChat(String uid) {
    this.uid = uid;
  }
  @override
  _ProfileChatState createState() => _ProfileChatState();
}

class _ProfileChatState extends State<ProfileChat> {
  List images = List();
  List nimages = [];
  List newurls;
  List<Asset> newimages = List<Asset>();

  String _error = 'No Error Dectected';

  String uname = '';
  String batch = '';
  String program = '';
  String workPlace = '';
  String designation = '';
  String city = '';
  String country = '';
  String university = '';
  String uemail = '';

  String uid;
  int temp = 0;
  List urls = [];

  DocumentSnapshot snap;

  @override
  void initState() {
    print(widget.uid);
    Api('users').getDocumentById(widget.uid).then((val) {
      setState(() {
        snap = val;
        snap != null
            ? snap.data['url'] == null
                ? images = []
                : setState(() {
                    images = snap.data['url'];
                  })
            : images = [];
        uname = snap != null
            ? snap.data['uname'] == null
                ? ''
                : snap.data['uname']
            : '';
        uname == ''
            ? uname = snap != null
                ? snap.data['email'] == null
                    ? ''
                    : snap.data['email']
                : ''
            : uname = '';
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
        batch = snap != null
            ? snap.data['batch'] == null
                ? ''
                : snap.data['batch']
            : '';
        program = snap != null
            ? snap.data['program'] == null
                ? ''
                : snap.data['program']
            : '';
        workPlace = snap != null
            ? snap.data['workPlace'] == null
                ? ''
                : snap.data['workPlace']
            : '';
        university = snap != null
            ? snap.data['university'] == null
                ? ''
                : snap.data['university']
            : '';
        designation = snap != null
            ? snap.data['designation'] == null
                ? ''
                : snap.data['designation']
            : '';
        country = snap != null
            ? snap.data['country'] == null
                ? ''
                : snap.data['country']
            : '';
        city = snap != null
            ? snap.data['city'] == null
                ? ''
                : snap.data['city']
            : '';
        snap != null
            ? snap.data['url'] == null
                ? urls = []
                : urls = snap.data['url']
            : urls = [];
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Profile")),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: ListView(
            shrinkWrap: true,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                  height: 400,
                  child: (urls.length == 0)
                      ? Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(25)),
                          height: 400,
                          width: double.infinity,
                        )
                      : PageView.builder(
                          itemCount: urls.length,
                          itemBuilder: (BuildContext context, int index1) {
                            print("anything123");
                            return Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(25)),
                                height: 400,
                                width: double.infinity,
                                child: CachedNetworkImage(
                                  imageUrl: urls[index1],
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ));
                          })),
              SizedBox(height: 25),
              Text(
                uname,
                style: TextStyle(color: Colors.grey[600], fontSize: 30),
              ),
              designation == '' ? Container() : SizedBox(height: 10),
              designation == ''
                  ? Container()
                  : Text(
                      "Designation: " + designation,
                      style: TextStyle(color: Colors.grey[600], fontSize: 20),
                    ),
              university == '' ? Container() : SizedBox(height: 10),
              university == ''
                  ? Container()
                  : Text(
                      "University: " + university,
                      style: TextStyle(color: Colors.grey[600], fontSize: 20),
                    ),
              city == '' ? Container() : SizedBox(height: 10),
              city == ''
                  ? Container()
                  : Text(
                      "City: " + city,
                      style: TextStyle(color: Colors.grey[600], fontSize: 20),
                    ),
              country == '' ? Container() : SizedBox(height: 10),
              country == ''
                  ? Container()
                  : Text(
                      "Country: " + country,
                      style: TextStyle(color: Colors.grey[600], fontSize: 20),
                    )
            ],
          ),
        ));
  }
}
