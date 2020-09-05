import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_note_app/database/firestore_service.dart';
import 'package:firebase_note_app/models/user.dart';
import 'package:flutter/cupertino.dart';

class UserAuthenticationService with ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  FirestoreService firestoreService = FirestoreService();
  User _currentUser;
  User get currentUser => _currentUser;

  Future createUserEmailAndPassword(
      {@required String name,
      @required String email,
      @required String password}) async {
    AuthResult result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    _currentUser = User(
      userId: result.user.uid,
      username: name,
      email: email,
    );
    await firestoreService.createUsers(_currentUser);
    // return result !
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
