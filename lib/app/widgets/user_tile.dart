import 'package:cached_network_image/cached_network_image.dart';
import 'package:datacard/app/data/models/user_model.dart';
import 'package:datacard/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserTile extends StatelessWidget {
  User user;
  UserTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Get.width * 0.05),
      decoration: BoxDecoration(
        color: ColorConstants.darkBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
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
                placeholder: (context, url) => CircularProgressIndicator(
                  color: Colors.white,
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
                width: Get.width * 0.18,
                height: Get.width * 0.18,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: TextStyle(
                  fontSize: 22,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                width: Get.width * 0.5,
                child: Text(
                  user.aadharNumber,
                  maxLines: 3,
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorConstants.borderColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
