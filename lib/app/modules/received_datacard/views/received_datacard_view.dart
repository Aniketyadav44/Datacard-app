import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../constants/app_constants.dart';
import '../../../../constants/color_constants.dart';
import '../../../data/models/document_model.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/document_tile.dart';
import '../../../widgets/logo.dart';
import '../controllers/received_datacard_controller.dart';

class ReceivedDatacardView extends GetView<ReceivedDatacardController> {
  ReceivedDatacardController receivedDatacardController =
      Get.find<ReceivedDatacardController>();
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
                () => receivedDatacardController.loading.value
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
                          Row(
                            children: [
                              Text(
                                receivedDatacardController.datacard.value.name,
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                margin:
                                    EdgeInsets.only(top: Get.height * 0.018),
                                child: Text("in Data Cards"),
                              ),
                            ],
                          ),
                          const Divider(
                            height: 30,
                            color: ColorConstants.borderColor,
                          ),
                          const SizedBox(
                            height: 10,
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
                            receivedDatacardController
                                .datacard.value.description,
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
                                    receivedDatacardController
                                        .datacard.value.addedOn),
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
                                receivedDatacardController.owner.value.name,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(
                            height: 30,
                            color: ColorConstants.borderColor,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Documents list:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          receivedDatacardController.docsList.isEmpty
                              ? const Center(
                                  child: Text(
                                    "No Documents found!",
                                    style: TextStyle(
                                      color: ColorConstants.secondaryTextColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: receivedDatacardController
                                      .docsList.length,
                                  itemBuilder: (context, index) {
                                    Document doc = receivedDatacardController
                                        .docsList[index];
                                    return DocumentTile(
                                      detailed: false,
                                      document: doc,
                                      onShareTap: () {},
                                      onEditTap: () {},
                                      onTap: () {
                                        receivedDatacardController.viewDocument(
                                          doc,
                                          receivedDatacardController
                                              .docCIDList.value[index],
                                        );
                                      },
                                    );
                                  },
                                )
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
