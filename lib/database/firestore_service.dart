import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_note_app/models/note.dart';
import 'package:flutter/cupertino.dart';

class FirestoreService with ChangeNotifier {
  final CollectionReference noteReference =
      Firestore.instance.collection('note');

  Stream fetchNoteAsStream() {
    return noteReference.orderBy('dateTime').snapshots();
  }

  Future addNote(Note note) async {
    return await noteReference.add(note.toMap());
  }

  Future updateNote(Note note, String id) async {
    return await noteReference.document(id).updateData(note.toMap());
  }

  Future deleteNote(String id) async {
    await noteReference.document(id).delete();
  }
}
