import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_note_app/screens/signin_form.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';

class AuthenticationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, snapshot) =>
            snapshot.hasData ? HomePage() : SignInForm());
  }
}
