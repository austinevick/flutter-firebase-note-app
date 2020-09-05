import 'package:firebase_note_app/constants/constant.dart';
import 'package:firebase_note_app/models/note.dart';
import 'package:firebase_note_app/widget/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class NoteList extends StatelessWidget {
  final Note note;

  const NoteList({Key key, this.note}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        elevation: 4,
        color: Theme.of(context).primaryColor,
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
                  onTap: () => showMaterialModalBottomSheet(
                      context: context,
                      builder: (context, scrollController) => NoteBottomSheet(
                            note: note,
                          )),
                  child: Icon(
                    Icons.more_vert,
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
}
