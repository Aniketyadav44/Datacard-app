import 'package:datacard/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class UpdateController extends GetxController {
  //TODO: Implement UpdateController
  HomeController homeController = Get.find<HomeController>();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
