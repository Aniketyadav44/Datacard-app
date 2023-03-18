import 'package:datacard/app/data/models/datacard_model.dart';
import 'package:datacard/app/modules/datacard/controllers/datacard_controller.dart';
import 'package:datacard/app/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../constants/app_constants.dart';
import '../../../../constants/color_constants.dart';
import '../../../data/models/document_model.dart';
import '../../../widgets/document_tile.dart';

class ViewDatacardView extends GetView {
  DatacardController datacardController = Get.find<DatacardController>();
  @override
  Widget build(BuildContext context) {
    Datacard datacard = Get.arguments[0];
    return Scaffold(
      body: Obx(
        () => datacardController.loading.value
            ? LoadingWidget()
            : Padding(
                padding: AppConstants.appPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Text(
                          datacard.name,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: Get.height * 0.018),
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
                      datacard.description,
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
                          DateFormat('dd/MM/yyyy').format(datacard.addedOn),
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
                    datacardController.datacardDocsList.value.isEmpty
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
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: datacardController
                                .datacardDocsList.value.length,
                            itemBuilder: (context, index) {
                              Document doc = datacardController
                                  .datacardDocsList.value[index];
                              return DocumentTile(
                                detailed: false,
                                document: doc,
                                onShareTap: () {},
                                onEditTap: () {},
                                onTap: () {
                                  // Get.to(ViewDocumentView(), arguments: [doc]);
                                },
                              );
                            },
                          )
                  ],
                ),
              ),
      ),
    );
  }
}
