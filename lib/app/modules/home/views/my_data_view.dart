import 'package:datacard/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_constants.dart';
import '../../../widgets/custom_list_tile.dart';

class MyDataView extends StatelessWidget {
  const MyDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppConstants.appPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "My Data",
              style: TextStyle(
                fontSize: AppConstants.screenHeading,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            CustomListTile(
              icon: Icons.insert_drive_file,
              text: "My Documents",
              onPressed: () {
                Get.toNamed(Routes.DOCUMENT);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            CustomListTile(
              icon: Icons.folder,
              text: "My Data Cards",
              onPressed: () {
                // Get.to(() => DataCardsScreen());
              },
            ),
            const SizedBox(
              height: 20,
            ),
            CustomListTile(
              icon: Icons.history,
              text: "Shared History",
              onPressed: () {},
            ),
            const SizedBox(
              height: 20,
            ),
            CustomListTile(
              icon: Icons.history,
              text: "Received History",
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
