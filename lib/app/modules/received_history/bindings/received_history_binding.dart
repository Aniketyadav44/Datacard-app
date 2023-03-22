import 'package:get/get.dart';

import '../controllers/received_history_controller.dart';

class ReceivedHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReceivedHistoryController>(
      () => ReceivedHistoryController(),
    );
  }
}
