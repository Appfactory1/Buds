import 'package:chat_app/firebase/auth.dart';
import 'package:chat_app/firebase/firestore.dart';
import 'package:chat_app/pages/buds.dart';
import 'package:chat_app/pages/interest.dart';
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
                      BudCat(name: "Native Buddies"),
                      BudCat(
                        name: "Work Buddies",
                      )
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BudCat(name: "Uni/College Buddies"),
                      BudCat(name: "Uni/College Buddies")
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
  const BudCat({
    this.name,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Buds(null, null, "", [])));
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
