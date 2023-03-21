import 'package:datacard/app/modules/receive/controllers/receive_controller.dart';
import 'package:datacard/app/widgets/user_tile.dart';
import 'package:datacard/constants/app_constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../constants/color_constants.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/datacard_tile.dart';
import '../../../widgets/document_tile.dart';
import '../../../widgets/logo.dart';

class StagingView extends GetView {
  ReceiveController receiveController = Get.find<ReceiveController>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.offAllNamed(Routes.HOME);
        return Future.value(false);
      },
      child: Scaffold(
        body: SafeArea(
          child: Obx(
            () => SingleChildScrollView(
              child: Padding(
                padding: AppConstants.appPadding,
                child: receiveController.loading.value
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
                            "Receiving,",
                            style: TextStyle(
                              fontSize: AppConstants.screenHeading,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "from",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          UserTile(user: receiveController.sharer.value),
                          const SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            width: Get.width,
                            child: Text(
                              receiveController.type == "dc"
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
                          receiveController.type == "dc"
                              ? DatacardTile(
                                  datacard: receiveController.dc.value,
                                  onEditTap: () {},
                                  onShareTap: () {},
                                  onTap: () {},
                                  detailed: false,
                                )
                              : DocumentTile(
                                  document: receiveController.doc.value,
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
                                receiveController.requestAccess();
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                backgroundColor: ColorConstants.secondaryColor,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.lock,
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
                                    "Request Access",
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
      ),
    );
  }
}
