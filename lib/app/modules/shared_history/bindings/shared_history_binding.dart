import 'package:get/get.dart';

import '../controllers/shared_history_controller.dart';

class SharedHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SharedHistoryController>(
      () => SharedHistoryController(),
    );
  }
}
