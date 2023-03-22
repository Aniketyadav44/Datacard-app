import 'package:datacard/app/routes/app_pages.dart';
import 'package:datacard/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/timout_controller.dart';

class TimoutView extends GetView<TimoutController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(Routes.HOME);
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // IconButton(
              //   icon: Icon(
              //     Icons.arrow_back,
              //     color: Colors.white,
              //     size: 30,
              //   ),
              //   onPressed: () {
              //     Get.offAllNamed(Routes.HOME);
              //   },
              // ),
              // SizedBox(
              //   height: Get.height * 0.8,
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Center(child: Text("Centered")),
              //     ],
              //   ),
              // ),
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppConstants.errorImg,
                        width: Get.width * 0.5,
                        height: Get.width * 0.5,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Oops!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * 0.1),
                        child: const Text(
                          "It seems our server is currently down, sorry for the inconvenience. We are working to fix it, Please try again after some times.",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
