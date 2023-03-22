import 'dart:convert';

import 'package:datacard/app/data/models/datacard_model.dart';
import 'package:datacard/app/data/models/document_model.dart';
import 'package:datacard/constants/app_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dioo;

import '../../modules/receive/controllers/receive_controller.dart';
import '../../routes/app_pages.dart';

class RequestProvider {
  dioo.Dio dio = dioo.Dio();

  Future<void> sendPushMessage(
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

  Future<Map<String, dynamic>> request(
    String type,
    String fileUID,
    Document doc,
    Datacard dc,
    String token,
    String ownerKey,
    ReceiveController receiveController,
  ) async {
    String requestType = type == "dc" ? "Data Card" : "Document";
    String fileName = type == "dc" ? dc.name : doc.name;

    receiveController.reqLoading(true);

    //sending notification to owner
    await sendPushMessage("Your $requestType \"$fileName\" has been requested!",
        "$requestType requested!", token, type, fileUID);

    Get.snackbar(
      "Requested",
      "Request for $fileName has been sent successfully!",
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );

    receiveController.timeMsg.value =
        "Please wait for the owner to grant access!";

    //sending request to backend
    Map<String, dynamic> data = {};
    try {
      var path = type == "dc"
          ? AppConstants.requestDataCardPath
          : AppConstants.requestFilePath;
      var link =
          "${AppConstants.protocol}://${AppConstants.domain}:${AppConstants.port}$path";
      dio.options.headers["x-api-key"] = AppConstants.apiKey;
      var reqParam = type == "dc" ? "dataCardUID" : "docUID";

      final response = await dio.post(
        link,
        data: {
          "secretKey": ownerKey,
          reqParam: fileUID,
        },
      );

      data = response.data;
    } catch (e) {
      print("error: $e");
    }

    receiveController.reqLoading(false);

    return data;
  }

  Future<bool> pingServer() async {
    try {
      var link =
          "${AppConstants.protocol}://${AppConstants.domain}:${AppConstants.port}${AppConstants.pingGetPath}";
      dio.options.headers["x-api-key"] = AppConstants.apiKey;
      dio.options.connectTimeout =
          Duration(seconds: int.parse(AppConstants.serverTimout));

      final response = await dio.get(
        link,
      );
      return true;
    } on dioo.DioError catch (e) {
      if (e.type == dioo.DioErrorType.connectionTimeout) {
        Get.toNamed(Routes.TIMOUT);
        return false;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}
