import 'package:datacard/app/data/services/firebase_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';

class FCMProvider with ChangeNotifier {
  static BuildContext? _context;

  static void setContext(BuildContext context) =>
      FCMProvider._context = context;

  //when app is in foreground
  static Future<void> onTapNotification(NotificationResponse? response) async {
    if (response?.payload == null) return;
    final Map<String, dynamic> data =
        FCMProvider.convertPayload(response!.payload!);
    var uidDataString = data["uidData"];
    var uidDataList = uidDataString.split('.');
    // 0 -> data type, 1 -> file uid, 2 -> requester uid
    Get.offAllNamed(Routes.LOCK, arguments: [
      data["screen"],
      uidDataList[0],
      uidDataList[1],
      uidDataList[2],
    ]);
  }

  static Map<String, dynamic> convertPayload(String payload) {
    final String _payload = payload.substring(1, payload.length - 1);
    List<String> _split = [];
    _payload.split(",")..forEach((String s) => _split.addAll(s.split(":")));
    Map<String, dynamic> _mapped = {};
    for (int i = 0; i < _split.length + 1; i++) {
      if (i % 2 == 1)
        _mapped.addAll({_split[i - 1].trim().toString(): _split[i].trim()});
    }
    return _mapped;
  }

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

  static Future<void> backgroundHandler(RemoteMessage message) async {}
}
