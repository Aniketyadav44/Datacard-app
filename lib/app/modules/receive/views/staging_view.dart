import 'package:datacard/app/modules/receive/controllers/receive_controller.dart';
import 'package:datacard/app/widgets/user_tile.dart';
import 'package:datacard/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';

import '../../../../constants/color_constants.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/datacard_tile.dart';
import '../../../widgets/document_tile.dart';
import '../../../widgets/logo.dart';

class StagingView extends GetView<ReceiveController> {
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
                                if (!receiveController.reqLoading.value &&
                                    receiveController.counter.value == 0) {
                                  receiveController
                                      .requestAccess(receiveController);
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Please wait...",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                backgroundColor:
                                    receiveController.counter.value != 0
                                        ? ColorConstants.secondaryDarkColor
                                        : ColorConstants.secondaryColor,
                              ),
                              child: receiveController.counter.value != 0
                                  ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          receiveController.counter.value != 0
                              ? Column(
                                  children: [
                                    Text(
                                      '00 : ${receiveController.counter.value.toString()}',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(receiveController.timeMsg.value),
                                  ],
                                )
                              : const SizedBox(),
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
