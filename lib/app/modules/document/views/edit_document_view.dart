import 'package:datacard/app/modules/document/controllers/document_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../constants/app_constants.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/logo.dart';

class EditDocumentView extends GetView {
  DocumentController documentController = Get.find<DocumentController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(
            () => documentController.loading.value
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
                        const Text(
                          "Edit Document",
                          style: TextStyle(
                            fontSize: AppConstants.screenHeading,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        CustomTextField(
                          hintText: "Name",
                          controller: documentController.nameController,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          hintText: "Description",
                          controller: documentController.descriptionController,
                          maxLines: 5,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomButton(
                          onPressed: documentController.editDocument,
                          text: "Update Document",
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
