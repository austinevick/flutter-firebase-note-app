import 'package:firebase_note_app/widget/confirmation_bottom_sheet.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../database/firestore_service.dart';
import 'package:firebase_note_app/models/note.dart';
import 'package:firebase_note_app/screens/alert_dialog_screen.dart';
import 'package:firebase_note_app/widget/share.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoteBottomSheet extends StatelessWidget {
  final Note note;

  const NoteBottomSheet({Key key, this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FirestoreService>(context);

    return Container(
      padding: EdgeInsets.all(8),
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              Navigator.of(context).pop();

              shareNote(context, note);
            },
            leading: Icon(
              Icons.share,
            ),
            title: Text('Share'),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              openCustomDialog(
                  context: context,
                  child: CustomDialogPage(
                    note: note,
                    isUpdating: true,
                  ));
            },
            leading: Icon(
              Icons.edit,
            ),
            title: Text('Edit'),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              showMaterialModalBottomSheet(
                  shape: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                  context: context,
                  builder: (
                    context,
                    scrollController,
                  ) =>
                      ConfirmationBottomSheet(
                        note: note,
                      ));
            },
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
