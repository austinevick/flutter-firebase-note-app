import 'package:firebase_note_app/database/firestore_service.dart';
import 'package:firebase_note_app/models/note.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CustomDialogPage extends StatefulWidget {
  final Note note;
  final bool isUpdating;
  const CustomDialogPage({Key key, this.isUpdating = false, this.note})
      : super(key: key);
  @override
  _CustomDialogPageState createState() => _CustomDialogPageState();
}

class _CustomDialogPageState extends State<CustomDialogPage> {
  final titleController = new TextEditingController();
  final contentController = new TextEditingController();

  @override
  void initState() {
    updateNoteList();
    super.initState();
  }

  updateNoteList() {
    if (widget.isUpdating == true) {
      titleController.text = widget.note.title;
      contentController.text = widget.note.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = Provider.of<FirestoreService>(context);
    return Dialog(
        shape: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
        child: Container(
          height: MediaQuery.of(context).size.height / 1.8,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.isUpdating ? 'Modify Note' : 'Add Note',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Divider(
                  thickness: 2,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8, left: 8),
                  child: TextField(
                    // cursorColor: Colors.black,
                    cursorWidth: 1.5,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    controller: titleController,
                    decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        hintText: 'Title'),
                  ),
                ),
                Divider(
                  thickness: 1.5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: TextField(
                    // cursorColor: Colors.black,
                    cursorWidth: 1.5,
                    maxLines: null,
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    style: TextStyle(fontSize: 16),
                    controller: contentController,
                    decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        hintText: 'Content'),
                  ),
                ),
                Divider(
                  thickness: 1.5,
                ),
                widget.isUpdating
                    ? Container()
                    : GestureDetector(
                        onTap: () => null,
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Set Notification(optional)',
                                style: TextStyle(fontSize: 17))),
                      ),
                SizedBox(
                  height: 10,
                ),
                ButtonBar(
                  buttonHeight: 45,
                  buttonMinWidth: 115,
                  alignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 45,
                      width: widget.isUpdating
                          ? 115
                          : MediaQuery.of(context).size.width / 1.3,
                      child: FlatButton(
                          shape: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          color: Colors.purple,
                          onPressed: () async {
                            Note note = Note(
                                dateTime: DateFormat.yMMMd()
                                    .add_Hm()
                                    .format(DateTime.now()),
                                title: titleController.text,
                                content: contentController.text);
                            if (titleController.text.isEmpty &&
                                contentController.text.isEmpty) return;
                            Navigator.pop(context);

                            if (widget.note == null) {
                              await p.addNote(note);
                            } else {
                              await p.updateNote(note, widget.note.id);
                            }
                          },
                          child: Text(widget.note == null ? 'DONE' : 'UPDATE',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white))),
                    ),
                    widget.note == null
                        ? Container()
                        : Container(
                            height: 45,
                            child: FlatButton(
                                shape: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                color: Colors.purple,
                                onPressed: () async {
                                  Navigator.pop(context);

                                  await p.deleteNote(widget.note.id);
                                },
                                child: Text('DELETE',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white))),
                          ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
