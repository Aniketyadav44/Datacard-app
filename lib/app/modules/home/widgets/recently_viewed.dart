import 'package:datacard/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_constants.dart';
import '../../../../constants/color_constants.dart';

class RecentlyViewed extends StatelessWidget {
  RecentlyViewed({super.key});

  HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Recently Viewed",
          style: TextStyle(
            fontSize: AppConstants.screenSubHeading,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          decoration: AppConstants.customBoxDecoration,
          child: homeController.user.value.recentlyViewed.isEmpty
              ? const SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: Center(
                    child: Text(
                      "No Recently Viewed Documents.",
                      style: TextStyle(
                        color: ColorConstants.secondaryTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              : Container(), //TODO change this to a listview builder in future
        )
      ],
    );
  }
}
