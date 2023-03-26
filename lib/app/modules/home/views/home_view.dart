import 'package:datacard/app/modules/home/views/my_data_view.dart';
import 'package:datacard/app/modules/home/views/user_home_screen.dart';
import 'package:datacard/app/modules/login/controllers/login_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../widgets/logo.dart';
import '../controllers/home_controller.dart';
import 'settings_view.dart';

class HomeView extends GetView<HomeController> {
  LoginController loginController = Get.find<LoginController>();
  HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (homeController.pageController.page == 0) {
          homeController.pageController.animateToPage(1,
              duration: const Duration(milliseconds: 400),
              curve: Curves.linear);
          return false;
        } else if (homeController.pageController.page == 2) {
          homeController.pageController.animateToPage(1,
              duration: const Duration(milliseconds: 400),
              curve: Curves.linear);
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Obx(() => homeController.loading.value
              ? Container(
                  height: Get.height,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Logo(),
                        const SizedBox(
                          height: 40,
                        ),
                        CircularProgressIndicator(),
                      ],
                    ),
                  ),
                )
              : PageView(
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
      ),
    );
  }
}
