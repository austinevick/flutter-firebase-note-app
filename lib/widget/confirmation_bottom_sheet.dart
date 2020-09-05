import 'package:firebase_note_app/database/firestore_service.dart';
import 'package:firebase_note_app/models/note.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfirmationBottomSheet extends StatelessWidget {
  final Note note;

  const ConfirmationBottomSheet({Key key, this.note}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FirestoreService>(context);

    return Container(
      height: MediaQuery.of(context).size.height / 3.5,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Delete Note',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('The selected note will be deleted'),
          ),
          Divider(),
          FlatButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await provider.deleteNote(note.userId);
              },
              child: Text(
                'DELETE',
                style: TextStyle(
                    color: Theme.of(
                  context,
                ).errorColor),
              )),
          Divider(),
          FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('CANCEL')),
        ],
      ),
    );
  }
}
