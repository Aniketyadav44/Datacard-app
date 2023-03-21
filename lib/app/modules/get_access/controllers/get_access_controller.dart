import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datacard/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/datacard_model.dart';
import '../../../data/models/document_model.dart';
import '../../../data/models/user_model.dart' as user;

class GetAccessController extends GetxController {
  var type = "".obs;
  var dataUID = "".obs;
  var reqUID = "".obs;

  var loading = false.obs;
  var accessLoading = false.obs;

  Rx<Document> doc = Document.initialize().obs;
  Rx<Datacard> dc = Datacard.initialize().obs;
  Rx<user.User> requester = user.User.initialize().obs;

  @override
  void onInit() {
    super.onInit();
    type.value = Get.arguments[0];
    dataUID.value = Get.arguments[1];
    reqUID.value = Get.arguments[2];
    print(type.value);
    print(dataUID.value);
    print(reqUID.value);
    loadData();
  }

  loadData() async {
    loading(true);

    String collection = type.value == "dc" ? "datacards" : "files";
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection(collection)
        .doc(dataUID.value)
        .get();
    if (type == "dc") {
      dc.value = Datacard.fromJson(snap.data() as Map<String, dynamic>);
    } else {
      doc.value = Document.fromJson(snap.data() as Map<String, dynamic>);
    }
    DocumentSnapshot userSnap = await FirebaseFirestore.instance
        .collection("users")
        .doc(reqUID.value)
        .get();
    requester.value =
        user.User.fromJson(userSnap.data() as Map<String, dynamic>);

    loading(false);
  }

  authorize() async {
    var currentUID = FirebaseAuth.instance.currentUser!.uid;
    if (currentUID != doc.value.owner && currentUID != dc.value.owner) {
      Get.snackbar(
        "Unauthorized",
        "You are not the owner of this data, access denied!",
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      accessLoading(true);
      var collectionName = type.value == "dc" ? "datacards" : "files";
      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(dataUID.value)
          .update({'access': true});
      Get.offAllNamed(Routes.HOME);
      Get.snackbar(
        "Access Granted",
        "Access has been granted to ${requester.value.name} successfully!",
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      accessLoading(false);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
