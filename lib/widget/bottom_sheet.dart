import 'package:firebase_note_app/models/note.dart';
import 'package:firebase_note_app/screens/alert_dialog_screen.dart';
import 'package:firebase_note_app/widget/alert_dialog.dart';
import 'package:firebase_note_app/widget/share.dart';
import 'package:flutter/material.dart';

class NoteBottomSheet extends StatelessWidget {
  final Note note;

  const NoteBottomSheet({Key key, this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          ListTile(
            onTap: () => shareNote(context, note),
            leading: Icon(
              Icons.share,
            ),
            title: Text('Share'),
          ),
          ListTile(
            onTap: () => openCustomDialog(
                context: context,
                child: CustomDialogPage(
                  note: note,
                  isUpdating: true,
                )),
            leading: Icon(
              Icons.edit,
            ),
            title: Text('Edit'),
          ),
          ListTile(
            leading: Icon(Icons.delete),
            title: Text('Delete'),
          ),
          ListTile(
            leading: Icon(Icons.archive),
            title: Text('Archived'),
          ),
          ListTile(
            leading: Icon(
              Icons.lock,
            ),
            title: Text('lock note'),
          ),
        ],
      ),
    );
  }
}
