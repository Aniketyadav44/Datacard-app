import 'package:datacard/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../constants/app_constants.dart';
import '../../../../constants/color_constants.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/logo.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginController loginController = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return !loginController.loading.value
        ? Scaffold(
            body: SafeArea(
              child: Padding(
                padding: AppConstants.authPadding,
                child: SingleChildScrollView(
                  child: Obx(() {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        const Logo(),
                        const SizedBox(
                          height: 50,
                        ),
                        Column(
                          children: [
                            CustomTextField(
                              hintText: 'Phone number',
                              controller: loginController.phoneController,
                              keyboardType: TextInputType.number,
                              prefixIcon: Container(
                                padding:
                                    EdgeInsets.only(top: Get.height * 0.017),
                                margin: EdgeInsets.only(right: 5),
                                child: Text(
                                  "+91",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          color: loginController.agreeTerms.value
                              ? ColorConstants.secondaryColor
                              : ColorConstants.secondaryDarkColor,
                          onPressed: () {
                            if (loginController.agreeTerms.value)
                              loginController.signinUser(context);
                          },
                          text: "Continue",
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Theme(
                              data: Theme.of(context).copyWith(
                                  unselectedWidgetColor: Colors.white),
                              child: Checkbox(
                                value: loginController.agreeTerms.value,
                                checkColor: Colors.white,
                                activeColor: ColorConstants.secondaryColor,
                                onChanged: (val) {
                                  loginController.agreeTerms.value = val!;
                                },
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.TERMS);
                              },
                              child: const Text(
                                "Agree to Terms and Conditions",
                                style: TextStyle(
                                  color: ColorConstants.secondaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          )
        : const LoadingWidget();
  }
}
