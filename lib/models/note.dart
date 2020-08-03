import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String id;
  final String title;
  final String content;
  final String dateTime;
  DocumentReference reference;
  Note({this.id, this.title, this.reference, this.dateTime, this.content});

  factory Note.fromMap(Map<String, dynamic> map, String documentID) {
    return Note(
        id: documentID,
        title: map['title'],
        dateTime: map['dateTime'] ?? '',
        content: map['content']);
  }
  Map<String, dynamic> toMap() {
    return {'title': title, 'content': content, 'dateTime': dateTime};
  }
}