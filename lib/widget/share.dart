import 'package:firebase_note_app/models/note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';

share(BuildContext context, Note note) async {
  await FlutterShare.share(
    chooserTitle: 'Share',
    title: '${note.title}',
    text: '${note.title}\n${note.content}\n${note.dateTime} ',
  );
}
