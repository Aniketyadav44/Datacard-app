import 'package:datacard/app/modules/document/controllers/document_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../constants/app_constants.dart';
import '../../../../constants/color_constants.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_choice_chip.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/logo.dart';

class AddDocumentView extends GetView {
  DocumentController documentController = Get.find<DocumentController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() => SingleChildScrollView(
              child: Padding(
                padding: AppConstants.appPadding,
                child: documentController.loading.value
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Add a Document",
                            style: TextStyle(
                              fontSize: AppConstants.screenHeading,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                hintText: "Name",
                                controller: documentController.nameController,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomTextField(
                                hintText: "Description",
                                controller:
                                    documentController.descriptionController,
                                maxLines: 5,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "filetype:",
                                style: TextStyle(
                                  color: ColorConstants.secondaryTextColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  CustomChoiceChip(
                                    selected: documentController
                                        .isTextFileTypeSelected.value,
                                    onSelected:
                                        documentController.selectTextChip,
                                    text: "Text",
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  CustomChoiceChip(
                                    selected: documentController
                                        .isImageFileTypeSelected.value,
                                    onSelected:
                                        documentController.selectImageChip,
                                    text: "Image",
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  CustomChoiceChip(
                                    selected: documentController
                                        .isPDFFileTypeSelected.value,
                                    onSelected:
                                        documentController.selectPdfChip,
                                    text: "PDF",
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomButton(
                                onPressed: documentController.selectDocument,
                                text: documentController
                                        .uploadFileName.value.isEmpty
                                    ? "Select Document"
                                    : documentController.uploadFileName.value +
                                        " (${documentController.uploadFileSize})",
                                color: ColorConstants.darkBackgroundColor,
                                isBoldText: false,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomButton(
                                onPressed: documentController.addDocument,
                                text: "Upload Document",
                              ),
                            ],
                          ),
                        ],
                      ),
              ),
            )),
      ),
    );
  }
}
