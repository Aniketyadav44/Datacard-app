import 'package:datacard/app/data/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/user_model.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final pageController = PageController(initialPage: 1);

  final count = 0.obs;
  Rx<User> user = User.initialize().obs;
  RxList userDocuments = [].obs;
  @override
  void onInit() {
    super.onInit();
    fetchUser();
  }

  fetchUser() async {
    UserProvider userProvider = UserProvider();
    user.value = await userProvider.fetchUser();
    userDocuments.value = await userProvider.fetchUserDocuments();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    pageController.dispose();
  }
}
