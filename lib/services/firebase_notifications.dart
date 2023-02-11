import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../constants/urls.dart';
import 'local_notifications.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  LocalNotificationService.initialize();
  log('Handling a background message: ${message.messageId}');
  LocalNotificationService.createanddisplaynotification(message);
}

class FirebaseNotifications {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  static Future<void> initialize() async {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    _firebaseMessaging.requestPermission();
    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) => {
          if (message != null)
            {
              LocalNotificationService.createanddisplaynotification(message),
              log('Message data: ${message.notification!.title}')
            },
        });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) => {
          LocalNotificationService.createanddisplaynotification(message),
          log('Message data: ${message.notification!.title}'),
        });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) => {
          LocalNotificationService.createanddisplaynotification(message),
          log('Message data: ${message.notification!.title}'),
        });

    const storage = FlutterSecureStorage();

    String? fcmToken = await storage.read(key: 'fcmToken');
    if (fcmToken == null) {
      fcmToken = await _firebaseMessaging.getToken();
      await storage.write(key: 'fcmToken', value: fcmToken);

      try {
        log("Hitting ${EndPoints.addFCMToken} with token $fcmToken");
        var response = await http.post(
          Uri.parse(EndPoints.addFCMToken),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'fcmToken': fcmToken,
          }),
        );
        var data = jsonDecode(response.body);
        if (response.statusCode == 201) {
          log(data.toString());
        } else {
          log(data.toString());
        }
      } catch (e) {
        log(e.toString());
      }
    }
    log('FCM Token: $fcmToken');
  }
}
