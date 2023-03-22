import 'package:get/get.dart';

import '../../../data/providers/history_provider.dart';

class SharedHistoryController extends GetxController {
  var loading = false.obs;

  RxList sharedHistory = [].obs;

  @override
  void onInit() {
    super.onInit();
    getSharedHistory();
  }

  getSharedHistory() async {
    loading(true);
    sharedHistory.value = await HistoryProvider().getHistory('shared');
    loading(false);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
