import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:movies_demo_app/models/push_notification.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../../screens/screens.export.dart';

class NotificationServices {
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    debugPrint('Handling a background message ${message.messageId}');
  }

  static late AndroidNotificationChannel channel;

  static late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  static Future<void> setNotificationSetting() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description:
            'This channel is used for important notifications.', // description
        importance: Importance.high,
      );
      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }

    if (Platform.isIOS) {
      FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    } else {
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  static notificatonsHandel(BuildContext context) {
    FirebaseMessaging.instance.getInitialMessage().then(
      (RemoteMessage? message) {
        if (message != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const HomeScreen(),
            ),
          );
        }
      },
    );
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        RemoteNotification? notification = message.notification;

        if (notification != null) {
          PushNotificationInfo notificationInfo = PushNotificationInfo(
            title: notification.title,
            body: notification.body,
            dataTitle: message.data['title'],
            dataBody: message.data['body'],
          );
          showSimpleNotification(
            Text(notificationInfo.title!),
            leading: const Icon(
              Icons.notification_add_sharp,
              color: Colors.red,
            ),
            subtitle: Text(notificationInfo.body!),
            background: Colors.cyan.shade700,
            duration: const Duration(seconds: 5),
          );
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('A new onMessageOpenedApp event was published!');
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ),
      );
    });
  }
}
