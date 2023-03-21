import 'package:datacard/app/data/models/datacard_model.dart';
import 'package:get/get.dart';

import '../../../data/models/document_model.dart';
import '../../../data/models/user_model.dart';
import '../../../data/providers/datacard_provider.dart';
import '../../../data/providers/document_provider.dart';
import '../../../data/providers/user_provider.dart';
import '../../../routes/app_pages.dart';

class ReceivedDatacardController extends GetxController {
  var loading = false.obs;

  Rx<Datacard> datacard = Datacard.initialize().obs;
  RxList docsList = [].obs;
  RxList docCIDList = [].obs;
  Rx<User> owner = User.initialize().obs;

  Map<String, dynamic> data = {};

  @override
  void onInit() {
    super.onInit();
    data = Get.arguments[0];
    loadDatacardDetails();
  }

  loadDatacardDetails() async {
    print(data["uid"]);
    loading(true);
    docsList.value = [];
    docCIDList.value = [];
    Map<String, dynamic> datacardData =
        await DatacardProvider().getDatacard(data["uid"]);
    datacard.value = Datacard.fromJson(datacardData);

    owner.value = await UserProvider().getUserByUID(datacard.value.owner);

    for (int i = 0; i < data["files"].length; i++) {
      var doc = data["files"][i]["uid"];
      var decryptedCID = data["files"][i]["decryptedCID"];

      Map<String, dynamic> docData = await DocumentProvider().getDocument(doc);
      docsList.add(Document.fromJson(docData));

      docCIDList.add(decryptedCID);
    }
    loading(false);
  }

  viewDocument(Document doc, cid) async {
    Get.toNamed(
      Routes.FILE,
      arguments: [
        doc.name,
        doc.type,
        cid,
      ],
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
