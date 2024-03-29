import 'package:datacard/app/data/models/datacard_model.dart';
import 'package:datacard/app/modules/datacard/controllers/datacard_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../constants/app_constants.dart';
import '../../../../constants/color_constants.dart';
import '../../../data/models/document_model.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/document_tile.dart';
import '../../../widgets/logo.dart';
import 'edit_datacard_view.dart';

class ViewDatacardView extends GetView {
  DatacardController datacardController = Get.find<DatacardController>();
  @override
  Widget build(BuildContext context) {
    Datacard datacard = Get.arguments[0];

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
                        Get.toNamed(Routes.SHARE, arguments: ["dc", datacard]);
                      },
                      text: "Share Datacard",
                      isBoldText: false,
                      height: 52,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        datacardController.nameController.text = datacard.name;
                        datacardController.descriptionController.text =
                            datacard.description;
                        datacardController.selectedDocs.value = datacard.files;
                        datacardController.editingDatacard = datacard;
                        datacardController.ifFromDialog = true;

                        Get.to(() => EditDatacardView());
                      },
                      text: "Update Datacard",
                      isBoldText: false,
                      height: 52,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        datacardController.deleteDatacard(
                            context, datacard.uid);
                      },
                      text: "Delete Datacard",
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
      body: SingleChildScrollView(
        child: Obx(
          () => datacardController.loading.value
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
                          SizedBox(
                            width: Get.width * 0.75,
                            child: Row(
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
                                Flexible(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top: Get.height * 0.018),
                                    child: Text(
                                      "in Data Cards",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                              physics: const NeverScrollableScrollPhysics(),
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
      ),
    );
  }
}
