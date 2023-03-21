import 'package:cached_network_image/cached_network_image.dart';
import 'package:datacard/app/data/models/user_model.dart';
import 'package:datacard/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_constants.dart';
import '../../../../constants/color_constants.dart';
import '../../../widgets/custom_floating_button.dart';
import '../widgets/most_commonly_used.dart';
import '../widgets/recently_viewed.dart';
import '../widgets/share_dialog.dart';
import '../widgets/usage_info.dart';

class UserHomeView extends StatelessWidget {
  User user;
  UserHomeView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    void share() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const ShareDialog();
        },
      );
    }

    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: AppConstants.appPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(
                        50,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                        imageUrl: user.photoUrl,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(
                          color: Colors.white,
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        width: Get.width * 0.2,
                        height: Get.width * 0.2,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: width * 0.46,
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name,
                          style: const TextStyle(fontSize: 20),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          user.uid,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.secondaryTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 70,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 1,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorConstants.borderColor,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: user.isVerified
                                      ? ColorConstants.greenColor
                                      : ColorConstants.yelloColor,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                user.isVerified ? "Verified" : "Unverified",
                                style: TextStyle(
                                  color: ColorConstants.secondaryTextColor,
                                  fontSize: user.isVerified ? 12 : 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        InkWell(
                          onTap: share,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 1,
                            ),
                            decoration: BoxDecoration(
                              color: ColorConstants.blueColor,
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.share,
                                  color: Colors.white,
                                  size: 15,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Share",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              RecentlyViewed(),
              const SizedBox(
                height: 40,
              ),
              MostCommonlyUsed(),
              const SizedBox(
                height: 40,
              ),
              const UsageInformation(),
            ],
          ),
        ),
      ),
      floatingActionButton: CustomFloatingButton(
        icon: Icons.camera_alt,
        onPressed: () {
          Get.toNamed(Routes.RECEIVE);
        },
      ),
    );
  }
}
