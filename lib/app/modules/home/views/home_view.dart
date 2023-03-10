import 'package:datacard/app/modules/home/views/my_data_view.dart';
import 'package:datacard/app/modules/home/views/user_home_screen.dart';
import 'package:datacard/app/modules/login/controllers/login_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'settings_view.dart';

class HomeView extends GetView<HomeController> {
  LoginController loginController = Get.find<LoginController>();
  HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() => PageView(
              controller: homeController.pageController,
              children: [
                MyDataView(),
                UserHomeView(
                  user: homeController.user.value,
                ),
                SettingsView(),
              ],
            )),
      ),
    );
  }
}
