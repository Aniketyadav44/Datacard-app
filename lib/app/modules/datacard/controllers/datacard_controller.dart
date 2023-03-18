import 'package:datacard/app/data/models/document_model.dart';
import 'package:datacard/app/data/providers/datacard_provider.dart';
import 'package:datacard/app/data/providers/document_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DatacardController extends GetxController {
  RxList<Document> datacardDocsList = <Document>[].obs;
  var loading = false.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  RxList<String> selectedDocs = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  selectDoc(Document doc) {
    selectedDocs.add(doc.uid);
  }

  unselectDoc(Document doc) {
    selectedDocs.removeWhere((element) => element == doc.uid);
  }

  fetchDatacardDocuments(List<String> docsList) async {
    loading(true);
    datacardDocsList.value = [];
    for (var docUID in docsList) {
      Map<String, dynamic> docData =
          await DocumentProvider().getDocument(docUID);
      datacardDocsList.add(Document.fromJson(docData));
    }
    loading(false);
  }

  addDatacard() async {
    if (nameController.text.isEmpty) {
      Get.snackbar(
        "Enter Name",
        "Please enter name of the document!",
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else if (descriptionController.text.isEmpty) {
      Get.snackbar(
        "Enter Description",
        "Please enter description of the document!",
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else if (selectedDocs.isEmpty || selectedDocs.length < 2) {
      Get.snackbar(
        "Select documents",
        "Please select atleast two documents!",
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      DatacardProvider().createDatacard(
        name: nameController.text,
        description: descriptionController.text,
        files: selectedDocs,
      );
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
