import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_note_app/models/note.dart';
import 'package:firebase_note_app/models/user.dart';
import 'package:flutter/cupertino.dart';

class FirestoreService with ChangeNotifier {
  final CollectionReference noteReference =
      Firestore.instance.collection('note');
  final CollectionReference usersReference =
      Firestore.instance.collection('users');

  fetchNoteAsStream() {
    return noteReference.orderBy('dateTime').snapshots().map((snapshot) {
      return snapshot.documents
          .map((e) => Note.fromMap(e.data, e.documentID))
          .toList();
    });
  }

  Future addNote(Note note) async {
    final userId = await FirebaseAuth.instance.currentUser();
    return await noteReference.document(userId.uid).setData(note.toMap());
  }

  Future createUsers(User user) async {
    await usersReference.document(user.userId).setData(user.toMap());
  }

  Future updateNote(Note note, String id) async {
    return await noteReference.document(id).updateData(note.toMap());
  }

  Future deleteNote(String id) async {
    await noteReference.document(id).delete();
  }
}
