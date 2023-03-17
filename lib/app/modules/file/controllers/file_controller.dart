import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datacard/app/data/providers/document_provider.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class FileController extends GetxController {
  var loading = false.obs;
  var documentName = "".obs;
  var documentType = "".obs;
  var fileCID = "".obs;
  var fileText = "".obs;
  var fileLoc = "".obs;
  @override
  void onInit() {
    super.onInit();
    fetchFile();
  }

  void fetchFile() async {
    loading.value = true;
    var docUID = Get.arguments[0];
    DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection("files").doc(docUID).get();
    Map<String, dynamic> fileData =
        documentSnapshot.data() as Map<String, dynamic>;
    documentName.value = fileData["name"];
    documentType.value = fileData["type"];

    fileCID.value =
        await DocumentProvider().getDocumentCID(fileData["encryptedCID"]);

    if (documentType == "text") {
      fileText.value = await DocumentProvider().getTextDocument(fileCID.value);
    }

    if (documentType == "pdf") {
      var fileDataBytes =
          await DocumentProvider().getPDFDocument(fileCID.value);
      var dir = await getApplicationDocumentsDirectory();
      var filename = "file.pdf";
      print("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");
      await file.writeAsBytes(fileDataBytes as List<int>, flush: true);
      fileLoc.value = "${dir.path}/$filename";
    }
    loading.value = false;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
