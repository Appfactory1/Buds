import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Api {
  final Firestore _db = Firestore.instance;
  final String path;
  CollectionReference ref;

  Api(this.path) {
    ref = _db.collection(path);
  }

  Future<QuerySnapshot> getDataCollection() {
    return ref.getDocuments();
  }

  Stream<QuerySnapshot> streamDataCollection() {
    return ref.snapshots();
  }

  Stream<QuerySnapshot> streamDataCollectionordered() {
    return ref.orderBy("time").snapshots();
  }

  Stream<QuerySnapshot> streamDataCollectionWithWhere(
      String key, String condition) {
    return ref.where(key, arrayContains: condition).snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.document(id).get();
  }

  Future<void> removeDocument(String id) {
    return ref.document(id).delete();
  }

  Future<DocumentReference> addDocument(Object data) {
    return ref.add(data);
  }

  Future<void> addDocumentById(Object data, String id) {
    return ref.document(id).setData(data);
  }

  Future<String> addDocumentGetId(Object data) async {
    final docRef = await ref.add(data);
    return docRef.documentID;
  }

  Future<void> updateDocument(Object data, String id) {
    return ref.document(id).updateData(data);
  }
}
