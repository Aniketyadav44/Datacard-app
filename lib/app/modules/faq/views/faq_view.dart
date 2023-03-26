import 'package:datacard/constants/app_constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../constants/color_constants.dart';
import '../controllers/faq_controller.dart';

class FaqView extends GetView<FaqController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: AppConstants.appPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "FAQs",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const Divider(
                  height: 30,
                  color: ColorConstants.borderColor,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: AppConstants.faq.length,
                  itemBuilder: (context, index) {
                    String q = "";
                    String a = "";
                    AppConstants.faq[index].entries.forEach((entry) {
                      q = entry.key;
                      a = (entry.value as String).replaceAll("\\n", "\n");
                    });
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: ColorConstants.darkBackgroundColor,
                      ),
                      child: ExpansionTile(
                        childrenPadding: EdgeInsets.all(10),
                        title: Text(
                          q,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        iconColor: Colors.white,
                        collapsedIconColor: Colors.white,
                        onExpansionChanged: (isOpened) {
                          if (isOpened) FocusScope.of(context).unfocus();
                        },
                        children: [
                          Text(a),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
