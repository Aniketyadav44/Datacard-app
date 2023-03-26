import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datacard/app/data/models/admin_request_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerificationController extends GetxController {
  var loading = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  requestVerification() async {
    loading(true);

    AdminRequest adminRequest = AdminRequest(
      requesterUID: FirebaseAuth.instance.currentUser!.uid,
      requestTitle: "Account Verification",
      requestDesc: "Request for account verification.",
      requestTime: DateTime.now(),
      uid: '',
    );

    await FirebaseFirestore.instance
        .collection("admin")
        .add(adminRequest.toJson())
        .then((value) async {
      await FirebaseFirestore.instance
          .collection("admin")
          .doc(value.id)
          .update({'uid': value.id});
      Get.back();
      Get.snackbar(
        "Requested",
        "Your request for account verification has been submitted!",
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    });

    loading(false);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
