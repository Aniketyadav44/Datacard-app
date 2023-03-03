import 'package:datacard/app/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/load_controller.dart';

class LoadView extends GetView<LoadController> {
  LoadController loadController = Get.find<LoadController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingWidget(),
    );
  }
}
