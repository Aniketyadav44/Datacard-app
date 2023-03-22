import 'package:flutter/material.dart';

import '../../../../constants/app_constants.dart';
import '../../../../constants/color_constants.dart';

class UsageInformation extends StatelessWidget {
  const UsageInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 12,
      ),
      decoration: AppConstants.customBoxDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(
                Icons.info,
                color: ColorConstants.secondaryTextColor,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "usage information",
                style: TextStyle(
                  fontSize: 13,
                  color: ColorConstants.secondaryTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "How to Share Documents/ Data Card:",
            style: TextStyle(
              fontSize: 13,
              color: ColorConstants.secondaryTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 5.0),
            child: Text(
              "1.Select the Documents/ Data Card.\n2.Click on Share button.\n3.Let the receiver scan the generated QR.",
              style: TextStyle(
                fontSize: 13,
                color: ColorConstants.secondaryTextColor,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "How to Receive Documents/ Data Card:",
            style: TextStyle(
              fontSize: 13,
              color: ColorConstants.secondaryTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 5.0),
            child: Text(
              "1.Scan the sender's QR code.\n2.Request for access.\n3.Authorize by granting access.",
              style: TextStyle(
                fontSize: 13,
                color: ColorConstants.secondaryTextColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
