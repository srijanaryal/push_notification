import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:notify/main.dart';

class FirebaseApi {
//create an instance of Firebae Messaging

  final _firebaseMessaging = FirebaseMessaging.instance;

//Function to initialize notificaios

  Future<void> initNotifications() async {
    //request permisision from user

    await FirebaseMessaging.instance.requestPermission();

    //fetch the firebase FCM TOKEN

    final fcmToken = await FirebaseMessaging.instance.getToken();

    print('Token : $fcmToken');
    initPushNotifications();

    //print the token
  }

//haldle receive messages

// if message is null
  void handleMessages(RemoteMessage? message) {
    if (message == null) return;
    navigatorKey.currentState
        ?.pushNamed('/notification_screen', arguments: message);
  }

//function to initialize Foreground and bg settigs

  Future initPushNotifications() async {
//handle id the app was terminated and now opened
    FirebaseMessaging.instance.getInitialMessage().then(handleMessages);

//attach event listeners for notifications opens app

    FirebaseMessaging.onMessageOpenedApp.listen(handleMessages);
  }
}
