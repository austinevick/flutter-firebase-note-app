import 'package:firebase_note_app/authentication/user_authentication.dart';
import 'package:firebase_note_app/screens/signin_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'homepage.dart';

class AuthenticationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<UserAuthenticationService>(context);
    return StreamBuilder(
      stream: auth.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomePage();
        } else
          return SignInForm();
      },
    );
  }
}
