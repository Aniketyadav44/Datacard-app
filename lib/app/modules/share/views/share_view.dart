import 'package:datacard/app/widgets/datacard_tile.dart';
import 'package:datacard/app/widgets/document_tile.dart';
import 'package:datacard/constants/app_constants.dart';
import 'package:datacard/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../widgets/logo.dart';
import '../controllers/share_controller.dart';

class ShareView extends GetView<ShareController> {
  ShareController shareController = Get.find<ShareController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => SingleChildScrollView(
            child: Padding(
              padding: AppConstants.appPadding,
              child: shareController.loading.value
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
                        const Text(
                          "Sharing,",
                          style: TextStyle(
                            fontSize: AppConstants.screenHeading,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          shareController.type == "dc"
                              ? "Data Card:"
                              : "Document:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(
                          height: 10,
                          color: ColorConstants.borderColor,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        shareController.type == "dc"
                            ? DatacardTile(
                                datacard: shareController.data,
                                onEditTap: () {},
                                onShareTap: () {},
                                onTap: () {},
                                detailed: false,
                              )
                            : DocumentTile(
                                document: shareController.data,
                                onEditTap: () {},
                                onShareTap: () {},
                                onTap: () {},
                                detailed: false,
                              ),
                        Stack(
                          children: [
                            Container(
                              height: Get.height * 0.5,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 50),
                              width: Get.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  const Text(
                                    'Scan to Receive',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: ColorConstants.borderColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: QrImage(
                                      data: shareController.encodedLink.value,
                                      backgroundColor: Colors.white,
                                      size: Get.width * 0.5,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Get.width * 0.15),
                                    child: Text(
                                      "Scan this QR code to receive Data from ${shareController.name} using Scanner of this App.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: ColorConstants.borderColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: Get.height * 0.03,
                              left: Get.width * 0.36,
                              child: Container(
                                width: Get.width * 0.15,
                                height: Get.width * 0.15,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: ColorConstants.backTintColor,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(100)),
                                child: SvgPicture.asset(
                                  AppConstants.logoPurple,
                                ),
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
    );
  }
}
