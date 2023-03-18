import 'dart:convert';

import 'package:datacard/app/data/local_storage.dart';
import 'package:datacard/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class ShareController extends GetxController {
  var type;
  var data;
  var secretKey;
  var loading = false.obs;
  var encodedLink = "".obs;
  var name = "".obs;

  HomeController homeController = Get.find<HomeController>();

  @override
  void onInit() {
    super.onInit();
    name.value = homeController.user.value.name;
    createQRLink();
  }

  createQRLink() {
    loading(true);
    type = Get.arguments[0];
    data = Get.arguments[1];
    secretKey = LocalStorage().getKey();
    var link = "${type}/${data.uid}/${secretKey}";
    encodedLink.value = utf8.encode(link).toString();
    loading(false);
    print(link);
    print(encodedLink);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
