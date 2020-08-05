import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User {
  CollectionReference noteRef;
  noteReference() async {
    final _user = await FirebaseAuth.instance.currentUser();

    noteRef = Firestore.instance.collection('note-${_user.uid}');
    return noteRef.document(_user.uid);
  }
}
