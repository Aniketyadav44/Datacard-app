import 'package:datacard/constants/app_constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../constants/color_constants.dart';
import '../../../widgets/datacard_tile.dart';
import '../../../widgets/document_tile.dart';
import '../../../widgets/logo.dart';
import '../../../widgets/user_tile.dart';
import '../controllers/get_access_controller.dart';

class GetAccessView extends GetView<GetAccessController> {
  GetAccessController getAccessController = Get.find<GetAccessController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: AppConstants.appPadding,
            child: Obx(
              () => getAccessController.loading.value
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
                      children: [
                        const Text(
                          "Grant access to,",
                          style: TextStyle(
                            fontSize: AppConstants.screenHeading,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        UserTile(user: getAccessController.requester.value),
                        const SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          width: Get.width,
                          child: Text(
                            getAccessController.type == "dc"
                                ? "Data Card:"
                                : "Document:",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Divider(
                          height: 10,
                          color: ColorConstants.borderColor,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        getAccessController.type == "dc"
                            ? DatacardTile(
                                datacard: getAccessController.dc.value,
                                onEditTap: () {},
                                onShareTap: () {},
                                onTap: () {},
                                detailed: false,
                              )
                            : DocumentTile(
                                document: getAccessController.doc.value,
                                onEditTap: () {},
                                onShareTap: () {},
                                onTap: () {},
                                detailed: false,
                              ),
                        const SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {
                              if (!getAccessController.accessLoading.value) {
                                getAccessController.authorize();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              backgroundColor:
                                  getAccessController.accessLoading.value
                                      ? ColorConstants.secondaryDarkColor
                                      : ColorConstants.secondaryColor,
                            ),
                            child: getAccessController.accessLoading.value
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.lock_open,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        "Authorize",
                                      ),
                                    ],
                                  ),
                          ),
                        )
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
