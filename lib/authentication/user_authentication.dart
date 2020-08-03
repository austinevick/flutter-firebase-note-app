import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserAuthenticationService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  Stream get onAuthStateChanged =>
      _auth.onAuthStateChanged.map((FirebaseUser user) => user?.uid);

  Future getCurrentUserId() async {
    return (await _auth.currentUser()).uid;
  }

  Future getCurrentUser() async {
    return await _auth.currentUser();
  }

  Future createUserEmailAndPassword(
      {@required String name,
      @required String email,
      @required String password}) async {
    final authResult = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    await userUpdateInfo(name, authResult.user);
    return authResult.user.uid;
  }

  Future userUpdateInfo(String name, FirebaseUser user) async {
    var userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = name;
    await user.updateProfile(userUpdateInfo);
    await user.reload();
  }

  Future signInWithEmailAndPassword(
      {@required String email, @required String password}) async {
    return (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user
        .uid;
  }

  Future resetPassword(String email) async {
    return _auth.sendPasswordResetEmail(email: email);
  }

  Future signInWithGoogle() async {
    final GoogleSignInAccount account = await googleSignIn.signIn();
    final GoogleSignInAuthentication authentication =
        await account.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: authentication.idToken,
        accessToken: authentication.accessToken);
    return (await _auth.signInWithCredential(credential)).user.uid;
  }

  signOut() {
    return _auth.signOut();
  }
}
