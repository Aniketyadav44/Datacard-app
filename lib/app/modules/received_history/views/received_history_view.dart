import 'package:datacard/app/widgets/history_tile.dart';
import 'package:datacard/constants/app_constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../constants/color_constants.dart';
import '../../../widgets/logo.dart';
import '../controllers/received_history_controller.dart';

class ReceivedHistoryView extends GetView<ReceivedHistoryController> {
  ReceivedHistoryController receivedHistoryController =
      Get.find<ReceivedHistoryController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(
            () => receivedHistoryController.loading.value
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
                        Text(
                          "Received History",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Divider(
                          height: 30,
                          color: ColorConstants.borderColor,
                        ),
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: receivedHistoryController
                                .receivedHistory.length,
                            itemBuilder: (context, index) {
                              return HistoryTile(
                                  history: receivedHistoryController
                                      .receivedHistory[index]);
                            }),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
