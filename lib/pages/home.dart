import 'package:chat_app/firebase/auth.dart';
import 'package:chat_app/firebase/firestore.dart';
import 'package:chat_app/pages/account_settings.dart';
import 'package:chat_app/pages/buds.dart';
import 'package:chat_app/pages/interest.dart';
import 'package:chat_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Position position;
  var addresses;
  String uid;
  var first;
  String username;
  String university;
  String designation;
  String loc;
  var interests;

  Future<void> _getLocation() async {
    position = await Geolocator().getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    var coordinates = Coordinates(position.latitude, position.longitude);
    addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    first = addresses.first;
    print(
        ' ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');
  }

  @override
  void initState() {
    Authentication().getUid().then((value) {
      uid = value;
    });
    _getLocation().then(
        (value) => Api('users').updateDocument({'loc': first.locality}, uid));
    super.initState();

    Api('users').getDocumentById('KOpQOBtk8xXLIVUp7RvRIVZ7agT2').then((value) {
      if (value.data['uname'] == null && value.data['uname'] == '') {
        print('kuss');
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AccountSettings()));
      } else {
        username = value.data['name'];
        university = value.data['university'];
        designation = value.data['designation'];
        loc = value.data['loc'];
        interests = value.data['interest'];
      }
    });
  }

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
        drawer: MyDrawer(),
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
                      BudCat(
                        name: "Native Buddies",
                        uname: username,
                        field: "loc",
                        value: loc,
                      ),
                      BudCat(
                        name: "Work Buddies",
                        uname: username,
                        field: "designation",
                        value: designation,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BudCat(
                        name: "Uni/College Buddies",
                        uname: username,
                        field: "university",
                        value: university,
                      ),
                      BudCat(
                        name: "Interest Buddies",
                        uname: username,
                        field: "interest",
                        value: interests,
                      )
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
  final String uname;
  final String field;
  final value;
  const BudCat({
    this.uname,
    this.field,
    this.value,
    this.name,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Buds(0, null, "", "", [], [], uname, field, value)));
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
