import 'package:get/get.dart';

import '../controllers/received_document_controller.dart';

class ReceivedDocumentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReceivedDocumentController>(
      () => ReceivedDocumentController(),
    );
  }
}
