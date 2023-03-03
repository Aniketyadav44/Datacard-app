import 'package:datacard/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../constants/app_constants.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          AppConstants.logoPurple,
          width: Get.width * 0.3,
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Data Card",
          style: TextStyle(
            fontSize: 40,
            color: ColorConstants.secondaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
