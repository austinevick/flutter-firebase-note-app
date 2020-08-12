import 'package:firebase_note_app/authentication/user_authentication.dart';
import 'package:firebase_note_app/constants/constant.dart';
import 'package:firebase_note_app/screens/forgot_password_form.dart';
import 'package:firebase_note_app/screens/screen_transition.dart';
import 'package:firebase_note_app/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'signup_form.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final formkey = new GlobalKey<FormState>();
  String email, password, error;
  bool isVisible = true;
  bool isLoading = false;
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
                  "sign in".toUpperCase(),
                  style: TextStyle(fontSize: 25, color: Colors.white),
                )),
              ),
            ),
            Container(
              child: Form(
                  key: formkey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: textFieldPadding,
                        child: Card(
                            child: TextFormField(
                          cursorColor: Colors.black,
                          cursorWidth: 1.5,
                          onSaved: (newValue) => email = newValue,
                          validator: (value) => !value.contains('@')
                              ? 'Please provide a valid email'
                              : null,
                          decoration:
                              textInputDecoration.copyWith(hintText: 'Email'),
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: textFieldPadding,
                        child: Card(
                            child: TextFormField(
                          cursorColor: Colors.black,
                          cursorWidth: 1.5,
                          obscureText: isVisible,
                          onSaved: (newValue) => password = newValue,
                          validator: (value) => value.length < 6
                              ? 'Password must be at least 6 characters'
                              : null,
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Password',
                              suffixIcon: IconButton(
                                icon: isVisible
                                    ? Icon(
                                        Icons.visibility,
                                        color: Colors.black,
                                      )
                                    : Icon(
                                        Icons.visibility_off,
                                        color: Colors.black,
                                      ),
                                onPressed: () =>
                                    setState(() => isVisible = !isVisible),
                              )),
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        )),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            PageTransition(
                                duration: Duration(milliseconds: 500),
                                child: ForgotPasswordForm(),
                                type: PageTransitionType.rightToLeft)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('FORGOT PASSWORD?',
                              style: TextStyle(color: Colors.black)),
                        ),
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
                              child: isLoading
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Text(
                                      'SIGN IN',
                                      style: buttonTextStyle,
                                    )),
                        ),
                      ),
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 50,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Don\'t have an account?',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          PageTransition(
                              duration: Duration(milliseconds: 500),
                              child: SignUpForm(),
                              type: PageTransitionType.downToUp)),
                      child: Text(
                        'Create account',
                        style: TextStyle(
                          color: Color(0xff171da7),
                        ),
                      ))
                ],
              ),
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
        if (mounted) setState(() => isLoading = true);
        await auth.signInWithEmailAndPassword(email: email, password: password);
      }
      if (mounted) setState(() => isLoading = true);
    } on PlatformException catch (e) {
      setState(() => isLoading = false);

      showDialog(
          context: context,
          builder: (context) => buildAlertDialog(context, e.message));
    }
  }
}
