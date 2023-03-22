import 'package:datacard/app/data/models/datacard_model.dart';
import 'package:datacard/app/modules/datacard/views/add_datacard_view.dart';
import 'package:datacard/app/modules/datacard/views/edit_datacard_view.dart';
import 'package:datacard/app/modules/datacard/views/view_datacard_view.dart';
import 'package:datacard/app/modules/home/controllers/home_controller.dart';
import 'package:datacard/app/widgets/datacard_tile.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../constants/app_constants.dart';
import '../../../../constants/color_constants.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/custom_floating_button.dart';
import '../controllers/datacard_controller.dart';

class DatacardView extends GetView<DatacardController> {
  HomeController homeController = Get.find<HomeController>();

  DatacardController datacardController = Get.find<DatacardController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => Padding(
            padding: AppConstants.appPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "My Data Cards",
                  style: TextStyle(
                    fontSize: AppConstants.screenHeading,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                homeController.userDatacards.isEmpty
                    ? const Center(
                        child: Text(
                          "No Data Cards found!",
                          style: TextStyle(
                            color: ColorConstants.secondaryTextColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: homeController.user.value.datacards.length,
                        itemBuilder: (context, index) {
                          Datacard dc =
                              homeController.userDatacards.value[index];
                          return DatacardTile(
                            datacard: dc,
                            onEditTap: () {
                              datacardController.nameController.text = dc.name;
                              datacardController.descriptionController.text =
                                  dc.description;
                              datacardController.selectedDocs.value = dc.files;
                              datacardController.editingDatacard = dc;

                              Get.to(() => EditDatacardView());
                            },
                            onShareTap: () {
                              Get.toNamed(Routes.SHARE, arguments: ["dc", dc]);
                            },
                            onTap: () {
                              datacardController
                                  .fetchDatacardDocuments(dc.files);
                              Get.to(() => ViewDatacardView(), arguments: [dc]);
                            },
                          );
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: CustomFloatingButton(
        icon: Icons.add,
        onPressed: () {
          datacardController.nameController.text = "";
          datacardController.descriptionController.text = "";

          Get.to(() => AddDatacardView());
        },
      ),
    );
  }
}
