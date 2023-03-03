import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datacard/app/data/local_storage.dart';
import 'package:datacard/app/data/models/document_model.dart';
import 'package:datacard/app/modules/document/controllers/document_controller.dart';
import 'package:datacard/app/modules/home/controllers/home_controller.dart';
import 'package:datacard/constants/app_constants.dart';
import 'package:dio/dio.dart' as dioo;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DocumentProvider {
  var link = "";
  dioo.Dio dio = dioo.Dio();

  //function to upload document
  uploadDocument(
      {required String name,
      required String description,
      required String fileType,
      required File document}) async {
    DocumentController documentController = Get.find<DocumentController>();
    HomeController homeController = Get.find<HomeController>();

    //preparing to upload file to server to get encrypted CID
    documentController.uploadingMessage.value = "Uploading & Hashing file...";
    link =
        "${AppConstants.protocol}://${AppConstants.domain}:${AppConstants.port}";
    dio.options.headers["x-api-key"] = AppConstants.apiKey;

    final formData = dioo.FormData.fromMap({
      'secretKey': LocalStorage().getKey(),
      'file': await dioo.MultipartFile.fromFile(document.path,
          filename: 'document'),
    });
    print('$link${AppConstants.uploadFilePath}');
    final response = await dio.post(
      '$link${AppConstants.uploadFilePath}',
      data: formData,
      onSendProgress: (count, total) {},
    );

    //preparing to uplaod file details on firestore with encrypted CID
    documentController.uploadingMessage.value = "Storing file details...";
    CollectionReference filesRef =
        FirebaseFirestore.instance.collection("files");
    await filesRef.add({
      'name': name,
      'description': description,
      'type': fileType,
      'encryptedCID': response.data["encryptedCID"],
      'uid': '',
      'access': false,
      'addedOn': DateTime.now(),
      'owner': FirebaseAuth.instance.currentUser!.uid,
    }).then((value) {
      print(value);
      //updating file's UID
      filesRef.doc(value.id).update({'uid': value.id});
      Document newDocument = Document(
        name: name,
        description: description,
        type: fileType,
        encryptedCID: response.data["encryptedCID"],
        uid: value.id,
        owner: FirebaseAuth.instance.currentUser!.uid,
        addedOn: DateTime.now(),
      );
      //Making local changes
      documentController.uploadingMessage.value = "Cleaning Up...";
      homeController.userDocuments.add(newDocument);
      //updating files list of the user
      List<String> userFiles = homeController.user.value.files;
      userFiles.add(value.id);
      FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'files': userFiles});
    });
    Get.back();
    Get.snackbar(
      "Uploaded",
      "Your file with name \"$name\" has been uploaded successfully",
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
