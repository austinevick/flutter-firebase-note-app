import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io' show File, Platform;

class NoteNotifications {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  NoteNotifications._() {
    init();
  }
  init() async {
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    if (Platform.isIOS) {
      _requestIOSPermission();
    }
  }

  initializePlatformSpecifics() {
    var initializeSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
  }

  _requestIOSPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        .requestPermissions(alert: false, badge: true, sound: true);
  }
}
