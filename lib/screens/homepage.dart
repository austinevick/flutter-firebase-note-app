import 'dart:async';

import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:firebase_note_app/database/firestore_service.dart';
import 'package:firebase_note_app/models/note.dart';
import 'package:firebase_note_app/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'alert_dialog_screen.dart';
import 'search_screen.dart';
import 'user_account_drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  changeTheme(BuildContext context) {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }

  @override
  Widget build(BuildContext context) {
    final noteNotifier = Provider.of<FirestoreService>(context);

    return Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.purple,
            foregroundColor: Colors.white,
            onPressed: () {
              _openCustomDialog(
                  child: CustomDialogPage(
                isUpdating: false,
              ));
            },
            child: Icon(
              Icons.add,
              size: 28,
            )),
        appBar: AppBar(
          leading: UserAccountDrawerScreen(),
          centerTitle: true,
          title: Text(
            'All Notes',
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
          elevation: 0,
          actions: <Widget>[
            AnimatedSwitcher(
              duration: Duration(seconds: 1),
              child: IconButton(
                  icon: Theme.of(context).brightness == Brightness.light
                      ? Icon(Icons.brightness_2)
                      : Icon(Icons.brightness_7),
                  onPressed: () =>
                      Timer(Duration(seconds: 1), () => changeTheme(context))),
            ),
            IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  showSearch(context: context, delegate: SearchScreen());
                }),
          ],
        ),
        body: StreamBuilder<List<Note>>(
            stream: noteNotifier.fetchNoteAsStream(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  snapshot.data.isEmpty
                      ? Center()
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            snapshot.data.length.toString() + ' Notes',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                  Expanded(
                      child: snapshot.data.isEmpty
                          ? Center(
                              child: Text(
                                'No note to display\ntap the + icon to begin',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              ),
                            )
                          : ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                final note = snapshot.data[index];
                                return GestureDetector(
                                    onTap: () => _openCustomDialog(
                                            child: CustomDialogPage(
                                          isUpdating: true,
                                          note: note,
                                        )),
                                    child: buildNoteList(context, note));
                              }))
                ],
              );
            }));
  }

  void _openCustomDialog({Widget child}) {
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
