import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreHelpers {
  FireStoreHelpers._();

  static final FireStoreHelpers fireStoreHelpers = FireStoreHelpers._();

  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<DocumentReference<Map<String, dynamic>>> insertdata(
      {required Map<String, dynamic> data}) async {
    DocumentReference<Map<String, dynamic>> docref =
        await firebaseFirestore.collection("notes").add(data);
    return docref;
  }

  Stream<QuerySnapshot> featchAllRecord() {
    return firebaseFirestore.collection("notes").snapshots();
  }

  Future<void> deleterecord({required String id}) async {
    return firebaseFirestore.collection("notes").doc(id).delete();
  }

  Future<void> updatedata(
      {required Map<String, dynamic> data, required String id}) async {
    await firebaseFirestore.collection("notes").doc(id).update(data);
  }
}
