import 'package:datacard/constants/color_constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../providers/fcm_provider.dart';

class FirebaseService {
  static FirebaseMessaging? _firebaseMessaging;
  static FirebaseMessaging get firebaseMessaging =>
      FirebaseService._firebaseMessaging ?? FirebaseMessaging.instance;

  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    FirebaseService._firebaseMessaging = FirebaseMessaging.instance;
    await FirebaseService.initializeLocalNotifications();
    await FCMProvider.onMessage();
    await FirebaseService.onBackgroundMsg();
  }

  Future<String?> getDeviceToken() async =>
      await FirebaseMessaging.instance.getToken();

  static FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //initializing local notifications with configs
  static Future<void> initializeLocalNotifications() async {
    final InitializationSettings _initSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );

    /// on did receive notification response = for when app is opened via notification while in foreground on android
    await FirebaseService.localNotificationsPlugin.initialize(
      _initSettings,
      onDidReceiveNotificationResponse: FCMProvider.onTapNotification,
    );

    /// need this for ios foregournd notification
    await FirebaseService.firebaseMessaging
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  //
  static NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
    'high_importance_channel', // id
    'High Importance Notifications',
    color: ColorConstants.secondaryColor,
    priority: Priority.max, // title
    importance: Importance.max,
  ));

  //for receiving messages when app is in foreground or background
  static Future<void> onMessage() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification notification = message.notification!;
      AndroidNotification? android = message.notification?.android;
      if (android != null) {
        await FirebaseService.localNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          FirebaseService.platformChannelSpecifics,
          payload: message.data.toString(),
        );
      }
    });
  }

  static Future<void> onBackgroundMsg() async {
    FirebaseMessaging.onBackgroundMessage(FCMProvider.backgroundHandler);
  }
}
