import 'dart:async';

import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    return DrawerHeader(
      child: FutureBuilder(
          future: pv.getCurrentUser(),
          builder: (context, snapshot) {
            FirebaseUser user = snapshot.data;
            return ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                    accountName: Text(
                      user.displayName,
                      style: TextStyle(fontSize: 16),
                    ),
                    accountEmail: Text(user.email)),
                Card(
                  child: ListTile(
                    onTap: () => pv.signOut(),
                    trailing: Icon(Icons.exit_to_app),
                    title: Text('Log out'),
                  ),
                )
              ],
            );
          }),
    );
  }
}
