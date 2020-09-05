import 'package:firebase_note_app/models/note.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class NoteBottomSheet extends StatelessWidget {
  final Note note;

  const NoteBottomSheet({Key key, this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height / 2,
    );
  }
}
