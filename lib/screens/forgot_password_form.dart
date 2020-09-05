import 'package:firebase_note_app/authentication/user_authentication.dart';
import 'package:firebase_note_app/constants/constant.dart';
import 'package:firebase_note_app/widget/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:provider/provider.dart';

class ForgotPasswordForm extends StatefulWidget {
  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final formkey = new GlobalKey<FormState>();
  String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipPath(
              clipper: WaveClipperTwo(),
              child: Container(
                height: 300,
                color: Color(0xff171da7),
                child: Center(
                    child: Text(
                  "reset password".toUpperCase(),
                  style: TextStyle(fontSize: 25, color: Colors.white),
                )),
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: textFieldPadding,
                    child: Card(
                        child: Form(
                      key: formkey,
                      child: TextFormField(
                        cursorColor: Colors.black,
                        cursorWidth: 1.5,
                        onSaved: (newValue) => email = newValue,
                        validator: (value) => !value.contains('@')
                            ? 'Please provide a valid email'
                            : null,
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
                        style: TextStyle(fontSize: 22, color: Colors.black),
                      ),
                    )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 55,
                      width: double.infinity,
                      child: FlatButton(
                          shape: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(50)),
                          color: Color(0xff171da7),
                          onPressed: () => submit(),
                          child: Text(
                            "reset password".toUpperCase(),
                            style: buttonTextStyle,
                          )),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 50,
              ),
              child: GestureDetector(
                  onTap: () => Navigator.pop(
                        context,
                      ),
                  child: Text(
                    'Return to sign in',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  submit() async {
    final auth = Provider.of<UserAuthenticationService>(context, listen: false);
    try {
      if (formkey.currentState.validate()) {
        formkey.currentState.save();
        await auth.resetPassword(email);
        return showDialog(
            context: context,
            builder: (context) => ErrorDialog(
                text: 'A password reset link has been sent to $email'));
      }
    } on PlatformException catch (e) {
      print(e);

      showDialog(
          context: context, builder: (context) => ErrorDialog(text: e.message));
    }
  }
}
