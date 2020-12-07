import 'package:file/file.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StorageApi {
  final storage = FirebaseStorage.instance;
  final String path;
  String downloadUrl = "";
  CollectionReference ref;

  StorageApi({this.path});

  Future<String> addImage(file) async {
    StorageTaskSnapshot snapshot =
        await storage.ref().child(path).putData(file).onComplete;
    if (snapshot.error == null) {
      downloadUrl = await snapshot.ref.getDownloadURL();
      // await Firestore.instance
      //     .collection("images")
      //     .add({"url": downloadUrl, "name": "kj"});
    }

    return downloadUrl;
  }

  Future<void> deleteImage(String url) async {
    StorageReference ref = await storage.getReferenceFromUrl(url);
    await ref.delete();
  }

  Future<String> addSound(file) async {
    StorageTaskSnapshot snapshot =
        await storage.ref().child(path).putData(file).onComplete;
    if (snapshot.error == null) {
      downloadUrl = await snapshot.ref.getDownloadURL();
      // await Firestore.instance
      //     .collection("images")
      //     .add({"url": downloadUrl, "name": "kj"});
    }

    return downloadUrl;
  }
}
