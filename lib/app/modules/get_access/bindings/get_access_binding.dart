import 'package:get/get.dart';

import '../controllers/get_access_controller.dart';

class GetAccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetAccessController>(
      () => GetAccessController(),
    );
  }
}
