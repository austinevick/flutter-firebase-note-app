import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_note_app/models/note.dart';
import 'package:firebase_note_app/models/user.dart';
import 'package:flutter/cupertino.dart';

class FirestoreService with ChangeNotifier {
  User user = new User();
  final CollectionReference noteReference =
      Firestore.instance.collection('note');

  Stream fetchNoteAsStream() {
    return noteReference.orderBy('dateTime').snapshots();
  }

  Future addNote(Note note) async {
    final _user = await FirebaseAuth.instance.currentUser();
    final user = _user.uid;
    return await noteReference.document(user).setData(note.toMap());
  }

  Future updateNote(Note note, String id) async {
    return await noteReference.document(id).updateData(note.toMap());
  }

  Future deleteNote(String id) async {
    await noteReference.document(id).delete();
  }
}
