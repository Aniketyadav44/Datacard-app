import 'package:datacard/app/modules/login/controllers/login_controller.dart';
import 'package:datacard/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_constants.dart';
import '../../../widgets/custom_list_tile.dart';

class SettingsView extends StatelessWidget {
  SettingsView({super.key});

  LoginController loginController = Get.find<LoginController>();

  void logOut() {
    loginController.logoutUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppConstants.appPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Settings",
              style: TextStyle(
                fontSize: AppConstants.screenHeading,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            CustomListTile(
              icon: Icons.verified_user,
              text: "Verify",
              onPressed: () {
                Get.toNamed(Routes.VERIFICATION);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            CustomListTile(
              icon: Icons.update,
              text: "Update Profile",
              onPressed: () {
                Get.toNamed(Routes.UPDATE);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            CustomListTile(
              icon: Icons.question_answer,
              text: "FAQs",
              onPressed: () {
                Get.toNamed(Routes.FAQ);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            CustomListTile(
              icon: Icons.logout,
              text: "Log Out",
              onPressed: logOut,
            ),
          ],
        ),
      ),
    );
  }
}
