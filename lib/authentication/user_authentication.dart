import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_note_app/database/firestore_service.dart';
import 'package:firebase_note_app/models/user.dart';
import 'package:flutter/cupertino.dart';

class UserAuthenticationService with ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Stream get onAuthStateChanged =>
      auth.onAuthStateChanged.map((FirebaseUser user) => user?.uid);

  Future getCurrentUserId() async {
    return (await auth.currentUser()).uid;
  }

  Future getCurrentUser() async {
    return await auth.currentUser();
  }

  Future createUserEmailAndPassword(
      {@required String name,
      @required String email,
      @required String password}) async {
    final authResult = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    return authResult.user.uid;
  }

  Future signInWithEmailAndPassword(
      {@required String email, @required String password}) async {
    return (await auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user
        .uid;
  }

  Future resetPassword(String email) async {
    return auth.sendPasswordResetEmail(email: email);
  }

  signOut() {
    return auth.signOut();
  }
}
