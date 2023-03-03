import 'package:datacard/app/data/models/document_model.dart';
import 'package:datacard/app/widgets/custom_button.dart';
import 'package:datacard/constants/app_constants.dart';
import 'package:datacard/constants/color_constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ViewDocumentView extends GetView {
  @override
  Widget build(BuildContext context) {
    Document? document = Get.arguments[0];
    return Scaffold(
      body: Padding(
        padding: AppConstants.appPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Text(
              document!.name,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              document.type == "image"
                  ? "Image file"
                  : document.type == "text"
                      ? "Text file"
                      : "PDF file",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(onPressed: () {}, text: "Open Document"),
            const SizedBox(
              height: 30,
            ),
            const Divider(
              height: 30,
              color: ColorConstants.borderColor,
            ),
            const Text(
              'Description:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              document.description,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  "Added on:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  DateFormat('dd/MM/yyyy').format(document.addedOn),
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
