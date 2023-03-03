import 'package:datacard/app/data/providers/document_provider.dart';
import 'package:get/get.dart';

import '../controllers/document_controller.dart';

class DocumentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DocumentController>(
      () => DocumentController(),
    );
    Get.lazyPut<DocumentProvider>(
      () => DocumentProvider(),
    );
  }
}
