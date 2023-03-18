import 'package:datacard/app/modules/document/views/add_document_view.dart';
import 'package:datacard/app/modules/document/views/view_document_view.dart';
import 'package:datacard/app/modules/home/controllers/home_controller.dart';
import 'package:datacard/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../constants/app_constants.dart';
import '../../../../constants/color_constants.dart';
import '../../../data/models/document_model.dart';
import '../../../widgets/custom_floating_button.dart';
import '../../../widgets/document_tile.dart';
import '../bindings/document_binding.dart';
import '../controllers/document_controller.dart';

class DocumentView extends GetView<DocumentController> {
  HomeController homeController = Get.find<HomeController>();
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
                  "My Documents",
                  style: TextStyle(
                    fontSize: AppConstants.screenHeading,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                homeController.userDocuments.value.isEmpty
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
                        itemCount: homeController.user.value.files.length,
                        itemBuilder: (context, index) {
                          Document doc =
                              homeController.userDocuments.value[index];
                          return DocumentTile(
                            document: doc,
                            onShareTap: () {
                              Get.toNamed(Routes.SHARE,
                                  arguments: ["doc", doc]);
                            },
                            onEditTap: () {},
                            onTap: () {
                              Get.to(ViewDocumentView(), arguments: [doc]);
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
          Get.to(() => AddDocumentView(), binding: DocumentBinding());
        },
      ),
    );
  }
}
