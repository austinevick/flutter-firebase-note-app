import 'package:flutter/material.dart';

class NoteAlertDialog extends StatelessWidget {
  final String text;

  const NoteAlertDialog({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
}
