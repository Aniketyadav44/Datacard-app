import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datacard/app/data/providers/document_provider.dart';
import 'package:datacard/app/data/providers/user_provider.dart';
import '../../../data/models/user_model.dart' as userModel;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class FileController extends GetxController {
  var loading = false.obs;
  var documentName = "".obs;
  var documentType = "".obs;
  var fileCID = "".obs;
  var fileText = "".obs;
  var fileLoc = "".obs;
  var isReceived = false.obs;
  @override
  void onInit() {
    super.onInit();
    final List args = Get.arguments;
    if (args.length > 1) {
      isReceived(true);
      documentName.value = args[0];
      documentType.value = args[1];
      fileCID.value = args[2];
    }
    fetchFile();
  }

  void fetchFile() async {
    loading.value = true;
    if (fileCID.value == "") {
      var docUID = Get.arguments[0];
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection("files")
          .doc(docUID)
          .get();
      Map<String, dynamic> fileData =
          documentSnapshot.data() as Map<String, dynamic>;
      documentName.value = fileData["name"];
      documentType.value = fileData["type"];

      fileCID.value =
          await DocumentProvider().getDocumentCID(fileData["encryptedCID"]);

      //registering in user's recently viewed documents
      userModel.User thisUser = await UserProvider().fetchUser();
      List<String> userRecentlyViewed = thisUser.recentlyViewed;
      userRecentlyViewed.insert(0, docUID);
      List<String> newList = [];
      if (userRecentlyViewed.length > 5) {
        for (int i = 0; i < 5; i++) {
          newList.add(userRecentlyViewed[i]);
        }
      } else {
        newList = userRecentlyViewed;
      }
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'recentlyViewed': newList});
    }

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
