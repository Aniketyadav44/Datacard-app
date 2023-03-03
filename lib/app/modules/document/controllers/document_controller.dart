import 'dart:io';
import 'dart:math';

import 'package:datacard/app/data/providers/document_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

class DocumentController extends GetxController {
  var loading = false.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Rx<File> uploadFile = File("").obs;
  RxString uploadFileName = "".obs;
  RxString uploadFileSize = "".obs;

  late String fileType;
  var isTextFileTypeSelected = false.obs;
  var isImageFileTypeSelected = false.obs;
  var isPDFFileTypeSelected = false.obs;

  void selectTextChip() {
    isTextFileTypeSelected(true);
    isImageFileTypeSelected(false);
    isPDFFileTypeSelected(false);
    uploadFile.value = File("");
    uploadFileName.value = "";
    uploadFileSize.value = "";
  }

  void selectImageChip() {
    isTextFileTypeSelected(false);
    isImageFileTypeSelected(true);
    isPDFFileTypeSelected(false);
    uploadFile.value = File("");
    uploadFileName.value = "";
    uploadFileSize.value = "";
  }

  void selectPdfChip() {
    isTextFileTypeSelected(false);
    isImageFileTypeSelected(false);
    isPDFFileTypeSelected(true);
    uploadFile.value = File("");
    uploadFileName.value = "";
    uploadFileSize.value = "";
  }

  //function to pick a document file
  void selectDocument() async {
    if (!isTextFileTypeSelected.value &&
        !isImageFileTypeSelected.value &&
        !isPDFFileTypeSelected.value) {
      Get.snackbar(
        "Select File Type",
        "Please first select a file type to upload!",
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      List<String> allowedExtensions = isTextFileTypeSelected.value
          ? ['txt']
          : isImageFileTypeSelected.value
              ? ['jpg', 'jpeg', 'png']
              : ['pdf'];
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: allowedExtensions,
      );
      if (result != null) {
        uploadFile.value = File(result.files.single.path!);
        uploadFileName.value = basename(uploadFile.value.path);
        uploadFileSize.value = await getFileSize(uploadFile.value.path, 2);
      }
    }
  }

  //function to get file size
  Future<String> getFileSize(String filepath, int decimals) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) +
        ' ' +
        suffixes[i];
  }

  //function to upload document
  void addDocument() {
    if (uploadFileName.value.isEmpty) {
      Get.snackbar(
        "Select Document",
        "Please select a document to upload!",
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else if (nameController.text.isEmpty) {
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
    } else {
      DocumentProvider documentProvider = Get.find<DocumentProvider>();
      documentProvider.uploadDocument(
        name: nameController.text,
        description: descriptionController.text,
        fileType: isTextFileTypeSelected.value
            ? "text"
            : isImageFileTypeSelected.value
                ? "image"
                : "pdf",
        document: uploadFile.value,
      );
    }
  }

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
}
