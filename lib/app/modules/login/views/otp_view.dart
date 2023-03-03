import 'package:datacard/app/modules/login/controllers/login_controller.dart';
import 'package:datacard/constants/color_constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../constants/app_constants.dart';
import '../../../widgets/custom_button.dart';

class OtpView extends GetView {
  LoginController loginController = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          return Padding(
            padding: AppConstants.authPadding,
            child: SingleChildScrollView(
              child: !loginController.codeSent.value
                  ? Container(
                      height: Get.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AppConstants.otpLock),
                          const SizedBox(
                            height: 40,
                          ),
                          const Text(
                            "Sending OTP",
                            style: TextStyle(
                              fontSize: 30,
                              color: ColorConstants.secondaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.1,
                            ),
                            child: const Text(
                              "Sending one-time password to your number for verification, please wait",
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
                          CircularProgressIndicator()
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Image.asset(AppConstants.otpOpenImg),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "OTP Verification",
                          style: TextStyle(
                            fontSize: 30,
                            color: ColorConstants.secondaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Get.width * 0.1,
                          ),
                          child: const Text(
                            "Enter the one-time password sent to your number",
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
                            length: 6,
                            onChanged: (String value) {},
                            pastedTextStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.underline,
                              borderRadius: BorderRadius.circular(50),
                              fieldOuterPadding: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.009),
                              borderWidth: 4,
                              fieldHeight: 50,
                              fieldWidth: 40,
                              activeColor: Colors.white,
                              selectedColor: ColorConstants.secondaryColor,
                              inactiveColor: ColorConstants.secondaryColor,
                            ),
                            showCursor: false,
                            controller: loginController.otpController,
                            keyboardType: TextInputType.number,
                            animationType: AnimationType.none,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          onPressed: () {
                            loginController.verifyOTP(context);
                          },
                          text: "Verify",
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
            ),
          );
        }),
      ),
    );
  }
}
