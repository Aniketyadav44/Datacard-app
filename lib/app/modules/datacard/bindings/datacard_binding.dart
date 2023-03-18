import 'package:get/get.dart';

import '../controllers/datacard_controller.dart';

class DatacardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DatacardController>(
      () => DatacardController(),
    );
  }
}
