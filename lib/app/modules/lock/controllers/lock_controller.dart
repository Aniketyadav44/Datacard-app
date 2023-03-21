import 'package:datacard/app/data/local_storage.dart';
import 'package:datacard/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LockController extends GetxController {
  TextEditingController lockPassController = TextEditingController();

  var loading = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  void verifyKey() {
    loading.value = true;
    String key = LocalStorage().getKey();
    if (lockPassController.text != key) {
      HapticFeedback.vibrate();
      Get.snackbar(
        "Invalid Key",
        "The entered security key was not valid, please try again!",
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      lockPassController.text = "";
      loading.value = false;
    } else {
      loading.value = false;
      final destRoute = Get.arguments[0];
      if (destRoute == Routes.GET_ACCESS) {
        var type = Get.arguments[1];
        var uid = Get.arguments[2];
        var reqUID = Get.arguments[3];
        // 0 -> data type, 1 -> file uid, 2 -> requester uid
        Get.offAllNamed(destRoute, arguments: [type, uid, reqUID]);
      } else {
        final uid = destRoute != Routes.HOME ? Get.arguments[1] : "";
        Get.offAllNamed(destRoute, arguments: [uid]);
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
