import 'package:datacard/app/widgets/logo.dart';
import 'package:datacard/constants/app_constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../constants/color_constants.dart';
import '../../../widgets/custom_button.dart';
import '../controllers/lock_controller.dart';

class LockView extends GetView<LockController> {
  LockController lockController = Get.find<LockController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: AppConstants.appPadding,
            child: Obx(
              () => Center(
                child: lockController.loading.value
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
                              const CircularProgressIndicator(),
                            ],
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          const SizedBox(
                            height: 40,
                          ),
                          const Logo(),
                          const SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.1,
                            ),
                            child: const Text(
                              "The app is locked, please enter your 4-digit security key",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: PinCodeTextField(
                              appContext: context,
                              length: 4,
                              onChanged: (String value) {},
                              pastedTextStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              pinTheme: PinTheme(
                                shape: PinCodeFieldShape.underline,
                                borderRadius: BorderRadius.circular(50),
                                fieldOuterPadding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.03),
                                borderWidth: 4,
                                fieldHeight: 50,
                                fieldWidth: 40,
                                activeColor: Colors.white,
                                selectedColor: ColorConstants.secondaryColor,
                                inactiveColor: ColorConstants.secondaryColor,
                              ),
                              showCursor: false,
                              controller: lockController.lockPassController,
                              keyboardType: TextInputType.number,
                              animationType: AnimationType.none,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomButton(
                            onPressed: () {
                              lockController.verifyKey();
                            },
                            text: "Continue",
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
