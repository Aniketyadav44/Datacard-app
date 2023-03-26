import 'package:datacard/app/modules/home/controllers/home_controller.dart';
import 'package:datacard/app/widgets/custom_button.dart';
import 'package:datacard/constants/app_constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../constants/color_constants.dart';
import '../../../widgets/logo.dart';
import '../controllers/verification_controller.dart';

class VerificationView extends GetView<VerificationController> {
  VerificationController verificationController =
      Get.find<VerificationController>();
  HomeController homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(
            () => verificationController.loading.value
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
                : Padding(
                    padding: AppConstants.appPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Verify",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Divider(
                          height: 30,
                          color: ColorConstants.borderColor,
                        ),
                        const Text(
                          'Verification status:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorConstants.borderColor,
                            ),
                            borderRadius: BorderRadius.circular(30),
                            color: homeController.user.value.isVerified
                                ? ColorConstants.greenColor
                                : ColorConstants.yelloColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                homeController.user.value.isVerified
                                    ? "Verified"
                                    : "Unverified",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Icon(
                                homeController.user.value.isVerified
                                    ? Icons.verified
                                    : Icons.cancel,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          homeController.user.value.isVerified
                              ? "You are verified,"
                              : "You are not verified,",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          homeController.user.value.isVerified
                              ? "Your Aadhar number has been verified by our team. Now you are a verified user."
                              : "There are two possibilities why you are not verified:\n1. Our team is yet to verify your Aadhar number.\n2. Your Aadhar number is invalid, please update it from update profile page & request again.",
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        homeController.user.value.isVerified
                            ? const SizedBox()
                            : CustomButton(
                                onPressed: () {
                                  verificationController.requestVerification();
                                },
                                text: "Request"),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
