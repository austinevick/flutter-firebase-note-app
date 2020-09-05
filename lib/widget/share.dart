import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:firebase_note_app/models/note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';

shareNote(BuildContext context, Note note) async {
  await FlutterShare.share(
    chooserTitle: 'Share',
    title: '${note.title}',
    text: '${note.title}\n${note.content}\n${note.dateTime} ',
  );
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

changeTheme(BuildContext context) {
  DynamicTheme.of(context).setBrightness(
      Theme.of(context).brightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark);
}
