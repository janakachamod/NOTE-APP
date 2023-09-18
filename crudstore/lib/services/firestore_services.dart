import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future insertNote(String title, String description, String userId) async {
    try {
      firestore.collection('notes').add({
        "title": title,
        "description": description,
        "date": DateTime.now(),
        "userId": userId
      });
    } catch (e) {}
  }

  Future updateNote(String docid, String title, String description) async {
    try {
      await firestore.collection('notes').doc(docid).update({
        "title": title,
        "description": description,
      });
    } catch (e) {}
  }
}
