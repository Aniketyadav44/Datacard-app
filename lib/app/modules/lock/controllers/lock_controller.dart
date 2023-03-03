import 'package:datacard/app/data/local_storage.dart';
import 'package:datacard/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
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
      Get.snackbar(
        "Invalid Key",
        "The entered security key was not valid, please try again!",
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      loading.value = false;
    } else {
      loading.value = false;
      Get.offAllNamed(Routes.HOME);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
