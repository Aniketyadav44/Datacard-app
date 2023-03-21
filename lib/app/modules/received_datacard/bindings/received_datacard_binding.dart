import 'package:get/get.dart';

import '../controllers/received_datacard_controller.dart';

class ReceivedDatacardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReceivedDatacardController>(
      () => ReceivedDatacardController(),
    );
  }
}
