import 'dart:io';

import 'package:datacard/app/modules/login/controllers/login_controller.dart';
import 'package:datacard/app/widgets/logo.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../constants/app_constants.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textfield.dart';

class RegisterView extends GetView {
  LoginController loginController = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppConstants.authPadding,
        child: Obx(() => SingleChildScrollView(
              child: loginController.loading.value
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
                        GestureDetector(
                          onTap: () {
                            loginController.pickImage();
                          },
                          child: Stack(
                            children: [
                              ClipRRect(
                                child: loginController.imageSelected.value
                                    ? Image.file(
                                        File(loginController.image.value.path),
                                        width: Get.width * 0.5,
                                        height: Get.width * 0.5,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        AppConstants.profileAvatar,
                                        width: Get.width * 0.5,
                                        height: Get.width * 0.5,
                                        fit: BoxFit.cover,
                                      ),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Icon(
                                  Icons.add_circle,
                                  color: Colors.white,
                                  size: 50,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Form(
                          key: loginController.registerFormKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                hintText: 'Name',
                                controller: loginController.nameController,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomTextField(
                                hintText: 'Email',
                                controller: loginController.emailController,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomTextField(
                                hintText: 'Aadhar Number',
                                controller: loginController.aadharNoController,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Tooltip(
                                  triggerMode: TooltipTriggerMode.tap,
                                  showDuration: Duration(seconds: 4),
                                  message:
                                      "Enter a security key of atleast 4 digit to access all the features of this app.",
                                  child: Row(
                                    children: [
                                      Text("Enter a security key"),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.info,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              CustomTextField(
                                hintText: 'Security Key',
                                controller: loginController.keyController,
                                keyboardType: TextInputType.number,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          onPressed: () {
                            loginController.register();
                          },
                          text: "Create Account",
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
            )),
      ),
    );
  }
}
