import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:datacard/constants/color_constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../constants/app_constants.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/logo.dart';
import '../controllers/update_controller.dart';

class UpdateView extends GetView<UpdateController> {
  UpdateController updateController = Get.find<UpdateController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppConstants.authPadding,
        child: Obx(() => SingleChildScrollView(
              child: updateController.loading.value
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
                        Text(
                          "Update",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.secondaryColor,
                            fontSize: 40,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            updateController.pickImage();
                          },
                          child: Stack(
                            children: [
                              ClipRRect(
                                child: updateController.imageSelected.value
                                    ? Image.file(
                                        File(updateController.image.value.path),
                                        width: Get.width * 0.5,
                                        height: Get.width * 0.5,
                                        fit: BoxFit.cover,
                                      )
                                    : CachedNetworkImage(
                                        imageUrl: updateController.imageLink,
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
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
                        Column(
                          children: [
                            CustomTextField(
                              hintText: 'Name',
                              controller: updateController.nameController,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                              hintText: 'Email',
                              controller: updateController.emailController,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                              hintText: 'Aadhar Number',
                              controller: updateController.aadharController,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          onPressed: () {
                            updateController.updateUser();
                          },
                          text: "Update Account",
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
