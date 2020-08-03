import 'package:firebase_note_app/authentication/user_authentication.dart';
import 'package:firebase_note_app/constants/constant.dart';
import 'package:firebase_note_app/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final formkey = new GlobalKey<FormState>();
  String name, email, password, error;
  bool isVisible = true;
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
                      "sign up".toUpperCase(),
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    )))),
            Form(
                key: formkey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: textFieldPadding,
                      child: Card(
                          child: TextFormField(
                        cursorColor: Colors.black,
                        cursorWidth: 1.5,
                        onSaved: (newValue) => name = newValue,
                        validator: (value) =>
                            value.isEmpty ? 'Please enter your name' : null,
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Name'),
                        style: TextStyle(fontSize: 22, color: Colors.black),
                      )),
                    ),
                    SizedBox(
                      height: 8,
                    ),
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
                        style: TextStyle(fontSize: 22, color: Colors.black),
                      )),
                    ),
                    SizedBox(
                      height: 8,
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
                                        Icons.visibility_off,
                                        color: Colors.black,
                                      )
                                    : Icon(
                                        Icons.visibility,
                                        color: Colors.black,
                                      ),
                                onPressed: () =>
                                    setState(() => isVisible = !isVisible))),
                        style: TextStyle(fontSize: 22, color: Colors.black),
                      )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //  LinearProgressIndicator(),
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
                              'CREATE ACCOUNT',
                              style: buttonTextStyle,
                            )),
                      ),
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(
                top: 50,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Already have an account?',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Text(
                        'Login',
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
        await auth.createUserEmailAndPassword(
            name: name, email: email, password: password);
      }
    } on PlatformException catch (e) {
      showDialog(
          context: context,
          builder: (context) => buildAlertDialog(context, e.message));
    }
  }
}
