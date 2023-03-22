import 'package:datacard/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/custom_button.dart';

class ShareDialog extends StatelessWidget {
  const ShareDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Sharing options",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
              onPressed: () {
                Navigator.of(context).pop();
                Get.toNamed(Routes.DOCUMENT);
              },
              text: "Share Documents",
              isBoldText: false,
              height: 52,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
              onPressed: () {
                Navigator.of(context).pop();
                Get.toNamed(Routes.DATACARD);
              },
              text: "Share Data Card",
              isBoldText: false,
              height: 52,
            ),
          ],
        ),
      ),
    );
  }
}
