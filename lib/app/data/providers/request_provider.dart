import 'dart:convert';

import 'package:datacard/constants/app_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class RequestProvider {
  void sendPushMessage(
    String body,
    String title,
    String token,
    String type,
    String fileUID,
  ) async {
    try {
      print("token: $token");
      String key = AppConstants.fcmKey;
      String myUID = FirebaseAuth.instance.currentUser!.uid;
      String uidDataString = "$type.$fileUID.$myUID";
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$key',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body,
              'title': title,
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done',
              'screen': '/get-access',
              'uidData': uidDataString,
            },
            "to": token,
          },
        ),
      );
      print('done');
    } catch (e) {
      print("error push notification");
    }
  }

  request(String type, String fileUID, String token) async {
    sendPushMessage("A document has been requested", "Document requested!",
        token, type, fileUID);
  }
}
