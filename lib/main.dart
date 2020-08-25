import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:firebase_note_app/authentication/user_authentication.dart';
import 'package:firebase_note_app/database/firestore_service.dart';
import 'package:firebase_note_app/screens/authentication_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FirestoreService(),
        ),
        ChangeNotifierProvider(create: (_) => UserAuthenticationService()),
      ],
      child: DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) => new ThemeData(
          primarySwatch: Colors.purple,
          textTheme: TextTheme(
            headline6: TextStyle(
              color: Colors.black,
            ),
          ),
          brightness: brightness,
        ),
        themedWidgetBuilder: (context, theme) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: theme,
          home: AuthenticationScreen(),
        ),
      ),
    );
  }
}

class Demo extends StatefulWidget {
  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
