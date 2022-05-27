import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class FirebaseServices {
  static Future<void> initializeMessaging() async {
    await Firebase.initializeApp();

    FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

    final token = await _firebaseMessaging.getToken();
    debugPrint(token);

    _firebaseMessaging.subscribeToTopic("all");

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }
}
