import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_note_app/constants/constant.dart';
import 'package:firebase_note_app/database/firestore_service.dart';
import 'package:firebase_note_app/models/note.dart';
import 'package:firebase_note_app/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'alert_dialog_screen.dart';

class SearchScreen extends SearchDelegate<Note> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      query.isEmpty
          ? SizedBox()
          : IconButton(icon: Icon(Icons.clear), onPressed: () => query = ''),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.keyboard_backspace,
          color: Colors.black,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    final noteNotifier = Provider.of<FirestoreService>(context);

    return StreamBuilder<QuerySnapshot>(
        stream: noteNotifier.fetchNoteAsStream(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: Container(
              color: Colors.white,
              height: 100,
              child: Row(
                children: <Widget>[
                  CircularProgressIndicator(),
                  Text(
                    'Loading data...',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ));
          }
          List<Note> noteList = snapshot.data.documents
              .map((e) => Note.fromMap(e.data, e.documentID))
              .where((element) => element.title.toLowerCase().contains(query))
              .toList();
          return ListView.builder(
              itemCount: noteList.length,
              itemBuilder: (context, index) {
                final note = noteList[index];
                return GestureDetector(
                    onTap: () => openCustomDialog(
                        context: context,
                        child: CustomDialogPage(
                          isUpdating: true,
                          note: note,
                        )),
                    child: buildNoteList(context, note));
              });
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final noteNotifier = Provider.of<FirestoreService>(context);

    return StreamBuilder<QuerySnapshot>(
        stream: noteNotifier.fetchNoteAsStream(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: Container(
              color: Colors.white,
              height: 100,
              child: Row(
                children: <Widget>[
                  CircularProgressIndicator(),
                  Text(
                    'Loading data...',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ));
          }
          List<Note> noteList = snapshot.data.documents
              .map((e) => Note.fromMap(e.data, e.documentID))
              .where((element) => element.title.toLowerCase().contains(query))
              .toList();
          return ListView.builder(
              itemCount: noteList.length,
              itemBuilder: (context, index) {
                final note = noteList[index];
                return GestureDetector(
                    onTap: () => openCustomDialog(
                        context: context,
                        child: CustomDialogPage(
                          isUpdating: true,
                          note: note,
                        )),
                    child: buildNoteList(context, note));
              });
        });
  }

  void openCustomDialog({BuildContext context, Widget child}) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
              scale: a1.value,
              child: Opacity(
                opacity: a1.value,
                child: child,
              ));
        },
        transitionDuration: Duration(milliseconds: 400),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {});
  }
}
