import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../constants/app_constants.dart';
import '../../../../constants/color_constants.dart';
import '../../../widgets/history_tile.dart';
import '../../../widgets/logo.dart';
import '../controllers/shared_history_controller.dart';

class SharedHistoryView extends GetView<SharedHistoryController> {
  SharedHistoryController sharedHistoryController =
      Get.find<SharedHistoryController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(
            () => sharedHistoryController.loading.value
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
                          "Shared History",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Divider(
                          height: 30,
                          color: ColorConstants.borderColor,
                        ),
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                sharedHistoryController.sharedHistory.length,
                            itemBuilder: (context, index) {
                              return HistoryTile(
                                  history: sharedHistoryController
                                      .sharedHistory[index]);
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
