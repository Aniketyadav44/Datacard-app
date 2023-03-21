import 'package:datacard/app/data/models/document_model.dart';
import 'package:datacard/app/data/models/user_model.dart';
import 'package:datacard/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../../data/providers/document_provider.dart';
import '../../../data/providers/user_provider.dart';

class ReceivedDocumentController extends GetxController {
  var loading = false.obs;

  Rx<Document> doc = Document.initialize().obs;
  Rx<User> owner = User.initialize().obs;

  Map<String, dynamic> data = {};

  @override
  void onInit() {
    super.onInit();
    data = Get.arguments[0];
    loadDocDetails();
  }

  loadDocDetails() async {
    loading(true);
    Map<String, dynamic> documentData =
        await DocumentProvider().getDocument(data["uid"]);
    doc.value = Document.fromJson(documentData);

    owner.value = await UserProvider().getUserByUID(doc.value.owner);
    loading(false);
  }

  viewDocument() async {
    Get.toNamed(
      Routes.FILE,
      arguments: [
        doc.value.name,
        doc.value.type,
        data["decryptedCID"],
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
