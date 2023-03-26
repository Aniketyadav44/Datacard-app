import 'package:datacard/app/data/models/document_model.dart';
import 'package:datacard/app/modules/document/controllers/document_controller.dart';
import 'package:datacard/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../constants/app_constants.dart';
import '../../../../constants/color_constants.dart';
import '../../document/views/view_document_view.dart';

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
        Obx(
          () => Container(
            decoration: AppConstants.customBoxDecoration,
            child: homeController.userRecentlyViewed.value.isEmpty
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
                : SizedBox(
                    width: Get.width,
                    height: Get.height * 0.18,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: homeController.userRecentlyViewed.value.length,
                      itemBuilder: (context, index) {
                        Document document =
                            homeController.userRecentlyViewed.value[index];
                        return GestureDetector(
                          onTap: () {
                            Get.lazyPut(() => DocumentController());
                            Get.to(() => ViewDocumentView(),
                                arguments: [document]);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 5,
                            ),
                            padding: const EdgeInsets.all(10),
                            width: Get.width * 0.3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorConstants.secondaryColor,
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/${document.type == "image" ? "image_file" : document.type == "text" ? "text_file" : "pdf_file"}.svg",
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Text(
                                    document.name,
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ), //TODO change this to a listview builder in future
          ),
        ),
      ],
    );
  }
}
