import 'package:datacard/app/data/providers/history_provider.dart';
import 'package:get/get.dart';

class ReceivedHistoryController extends GetxController {
  var loading = false.obs;

  RxList receivedHistory = [].obs;

  @override
  void onInit() {
    super.onInit();
    getReceivedHistory();
  }

  getReceivedHistory() async {
    loading(true);
    receivedHistory.value = await HistoryProvider().getHistory('received');
    print("val: ${receivedHistory.value}");
    loading(false);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
