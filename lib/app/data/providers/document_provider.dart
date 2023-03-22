import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datacard/app/data/local_storage.dart';
import 'package:datacard/app/data/models/document_model.dart';
import 'package:datacard/app/data/providers/user_provider.dart';
import 'package:datacard/app/modules/document/controllers/document_controller.dart';
import 'package:datacard/app/modules/home/controllers/home_controller.dart';
import 'package:datacard/app/routes/app_pages.dart';
import 'package:datacard/constants/app_constants.dart';
import 'package:dio/dio.dart' as dioo;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
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
    try {
      DocumentController documentController = Get.find<DocumentController>();
      HomeController homeController = Get.find<HomeController>();

      //preparing to upload file to server to get encrypted CID
      documentController.uploadingMessage.value = "Uploading & Hashing file...";
      link =
          "${AppConstants.protocol}://${AppConstants.domain}:${AppConstants.port}";
      dio.options.headers["x-api-key"] = AppConstants.apiKey;
      dio.options.connectTimeout =
          Duration(seconds: int.parse(AppConstants.serverTimout));

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
      }).then((value) async {
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
        await FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'files': userFiles});
        homeController.user.value = await UserProvider().fetchUser();
      });
      documentController.uploadingMessage.value = "";
      documentController.loading.value = false;
      Get.back();
      Get.snackbar(
        "Uploaded",
        "Your file with name \"$name\" has been uploaded successfully",
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } on dioo.DioError catch (e) {
      if (e.type == dioo.DioErrorType.connectionTimeout) {
        Get.toNamed(Routes.TIMOUT);
      }
    } catch (e) {
      print(e);
    }
  }

  //decrypting cid
  Future<String> getDocumentCID(String encCID) async {
    try {
      link =
          "${AppConstants.protocol}://${AppConstants.domain}:${AppConstants.port}${AppConstants.decryptCIDPath}";
      dio.options.headers["x-api-key"] = AppConstants.apiKey;
      dio.options.connectTimeout =
          Duration(seconds: int.parse(AppConstants.serverTimout));
      final response = await dio.post(
        link,
        data: {"secretKey": LocalStorage().getKey(), "encrypted": encCID},
      );

      final CID = response.data["CID"];

      return CID;
    } on dioo.DioError catch (e) {
      if (e.type == dioo.DioErrorType.connectionTimeout) {
        Get.toNamed(Routes.TIMOUT);
      }
    } catch (e) {
      print(e);
    }
    return "";
  }

  Future editDocument(String uid, String name, String desc) async {
    await FirebaseFirestore.instance.collection("files").doc(uid).update({
      'name': name,
      'description': desc,
    });
  }

  Future<Map<String, dynamic>> getDocument(String uid) async {
    DocumentSnapshot docSnapshot =
        await FirebaseFirestore.instance.collection("files").doc(uid).get();
    return docSnapshot.data() as Map<String, dynamic>;
  }

  Future getTextDocument(String cid) async {
    final response = await dio.get("https://ipfs.io/ipfs/$cid");
    return response.data;
  }

  Future getPDFDocument(String cid) async {
    final url = "https://ipfs.io/ipfs/$cid";
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    return bytes;
  }

  Future deleteDocument(String uid) async {
    await FirebaseFirestore.instance.collection("files").doc(uid).delete();
  }
}
