import 'package:get/get.dart';

import '../controllers/timout_controller.dart';

class TimoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TimoutController>(
      () => TimoutController(),
    );
  }
}
