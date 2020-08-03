import 'package:firebase_note_app/constants/constant.dart';
import 'package:firebase_note_app/models/note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';

buildAlertDialog(BuildContext context, String text) {
  return AlertDialog(
    title: Icon(Icons.error_outline),
    content: Text(text),
    actions: <Widget>[
      FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'OK',
            style: TextStyle(fontSize: 20),
          ))
    ],
  );
}

buildNoteList(BuildContext context, Note note) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Card(
      elevation: 4,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(children: <Widget>[
              note.title.isEmpty
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                      ),
                      child: Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(50)),
                      ),
                    ),
              note.title.isEmpty
                  ? Center()
                  : Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                        ),
                        child: Text(
                          note.title,
                          style: titleTextStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
              Spacer(),
              GestureDetector(
                onTap: () => share(context, note),
                child: Icon(
                  Icons.share,
                  color: Colors.black,
                ),
              )
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50),
            child: Text(note.content, style: contentTextStyle),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50, top: 5, bottom: 12),
            child: Text(
              note.dateTime,
              style: TextStyle(color: Colors.black54),
            ),
          ),
        ],
      ),
    ),
  );
}

share(BuildContext context, Note note) async {
  await FlutterShare.share(
    chooserTitle: 'Share',
    title: '${note.title}',
    text: '${note.title}\n${note.content}\n${note.dateTime} ',
  );
}
