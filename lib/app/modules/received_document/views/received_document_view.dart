import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../constants/app_constants.dart';
import '../../../../constants/color_constants.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/logo.dart';
import '../controllers/received_document_controller.dart';

class ReceivedDocumentView extends GetView<ReceivedDocumentController> {
  ReceivedDocumentController receivedDocumentController =
      Get.find<ReceivedDocumentController>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.offAllNamed(Routes.HOME);
        return Future.value(false);
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: AppConstants.appPadding,
              child: Obx(
                () => receivedDocumentController.loading.value
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
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            receivedDocumentController.doc.value.name,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            receivedDocumentController.doc.value.type == "image"
                                ? "Image file"
                                : receivedDocumentController.doc.value.type ==
                                        "text"
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
                                receivedDocumentController.viewDocument();
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
                            receivedDocumentController.doc.value.description,
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
                                DateFormat('dd/MM/yyyy').format(
                                    receivedDocumentController
                                        .doc.value.addedOn),
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                "Owner:",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                receivedDocumentController.owner.value.name,
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
          ),
        ),
      ),
    );
  }
}
