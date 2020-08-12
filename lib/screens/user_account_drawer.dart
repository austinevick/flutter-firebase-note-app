import 'package:firebase_note_app/authentication/user_authentication.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserAccountDrawerScreen extends StatefulWidget {
  @override
  _UserAccountDrawerScreenState createState() =>
      _UserAccountDrawerScreenState();
}

class _UserAccountDrawerScreenState extends State<UserAccountDrawerScreen> {
  @override
  Widget build(BuildContext context) {
    final pv = Provider.of<UserAuthenticationService>(context);
    return PopupMenuButton(itemBuilder: (context) {
      return [
        PopupMenuItem(
            height: 35,
            child: GestureDetector(
                onTap: () {
                  pv.signOut();
                  Navigator.of(context).pop();
                },
                child: Text('Log out'))),
      ];
    });
  }
}
