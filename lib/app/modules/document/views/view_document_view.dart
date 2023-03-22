import 'package:datacard/app/data/models/document_model.dart';
import 'package:datacard/app/modules/document/controllers/document_controller.dart';
import 'package:datacard/app/widgets/custom_button.dart';
import 'package:datacard/constants/app_constants.dart';
import 'package:datacard/constants/color_constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/logo.dart';
import 'edit_document_view.dart';

class ViewDocumentView extends GetView<DocumentController> {
  DocumentController documentController = Get.find<DocumentController>();
  @override
  Widget build(BuildContext context) {
    Document? document = Get.arguments[0];

    more() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                height: Get.height * 0.3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Get.toNamed(Routes.SHARE, arguments: ["doc", document]);
                      },
                      text: "Share Document",
                      isBoldText: false,
                      height: 52,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        documentController.ifFromDialog = true;
                        documentController.nameController.text = document!.name;
                        documentController.descriptionController.text =
                            document.description;
                        documentController.editingDocument = document;
                        Get.to(() => EditDocumentView());
                      },
                      text: "Update Document",
                      isBoldText: false,
                      height: 52,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        documentController.deleteDocument(
                            context, document!.uid);
                      },
                      text: "Delete Document",
                      isBoldText: false,
                      height: 52,
                    ),
                  ],
                ),
              ),
            );
          });
    }

    return Scaffold(
      body: Obx(
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
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          document!.name,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        IconButton(
                          onPressed: more,
                          icon: Icon(
                            Icons.more_vert_outlined,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      document.type == "image"
                          ? "Image file"
                          : document.type == "text"
                              ? "Text file"
                              : "PDF file",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomButton(
                        onPressed: () {
                          documentController.viewDocument(document.uid);
                        },
                        text: "Open Document"),
                    const SizedBox(
                      height: 30,
                    ),
                    const Divider(
                      height: 30,
                      color: ColorConstants.borderColor,
                    ),
                    const Text(
                      'Description:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      document.description,
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "Added on:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          DateFormat('dd/MM/yyyy').format(document.addedOn),
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
