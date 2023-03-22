import 'package:datacard/app/modules/datacard/controllers/datacard_controller.dart';
import 'package:datacard/app/modules/home/controllers/home_controller.dart';
import 'package:datacard/app/widgets/custom_checkbox_tile.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../constants/app_constants.dart';
import '../../../../constants/color_constants.dart';
import '../../../data/models/document_model.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/logo.dart';

class EditDatacardView extends GetView {
  DatacardController datacardController = Get.find<DatacardController>();
  HomeController homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
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
                        const Text(
                          "Edit Data Card",
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
                          controller: datacardController.nameController,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          hintText: "Description",
                          controller: datacardController.descriptionController,
                          maxLines: 5,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: ColorConstants.darkBackgroundColor,
                          ),
                          child: ExpansionTile(
                            title: Text(
                              "Update documents",
                              style: TextStyle(
                                color: ColorConstants.secondaryTextColor,
                              ),
                            ),
                            iconColor: Colors.white,
                            collapsedIconColor: Colors.white,
                            onExpansionChanged: (isOpened) {
                              if (isOpened) FocusScope.of(context).unfocus();
                            },
                            children: List.generate(
                              homeController.userDocuments.value.length,
                              (index) {
                                Document doc =
                                    homeController.userDocuments[index];
                                return CustomCheckBox(
                                    title: doc.name,
                                    isChecked: datacardController.selectedDocs
                                        .contains(doc.uid),
                                    onChanged: (value) {
                                      if (value!) {
                                        datacardController.selectDoc(doc);
                                      } else {
                                        datacardController.unselectDoc(doc);
                                      }
                                    });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomButton(
                          onPressed: datacardController.updateDatacard,
                          text: "Update Data Card",
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
