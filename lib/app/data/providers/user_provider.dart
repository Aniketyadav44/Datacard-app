import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datacard/app/data/models/datacard_model.dart';
import 'package:datacard/app/modules/home/controllers/home_controller.dart';
import 'package:datacard/app/modules/update/controllers/update_controller.dart';
import '../models/document_model.dart' as docModel;
import 'package:datacard/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user_model.dart' as userModel;

class UserProvider {
  //get user details
  Future<userModel.User> fetchUser() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    String uid = firebaseAuth.currentUser!.uid;
    DocumentSnapshot user =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();
    return userModel.User.fromJson(user.data() as Map<String, dynamic>);
  }

  //get user's documents
  Future<List<docModel.Document>> fetchUserDocuments() async {
    HomeController homeController = Get.find<HomeController>();
    List<docModel.Document> docList = [];
    for (var docUID in homeController.user.value.files) {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection("files")
          .doc(docUID)
          .get();
      docList
          .add(docModel.Document.fromJson(doc.data() as Map<String, dynamic>));
    }
    return docList;
  }

  //get user's recently viewed documents
  Future<List<docModel.Document>> fetchUserRecentlyViewedDocuments() async {
    HomeController homeController = Get.find<HomeController>();
    List<docModel.Document> docList = [];
    for (var docUID in homeController.user.value.recentlyViewed) {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection("files")
          .doc(docUID)
          .get();
      docList
          .add(docModel.Document.fromJson(doc.data() as Map<String, dynamic>));
    }
    return docList;
  }

  //get user's datacards
  Future<List<Datacard>> fetchUserDatacards() async {
    HomeController homeController = Get.find<HomeController>();
    List<Datacard> datacardList = [];
    for (var dcUID in homeController.user.value.datacards) {
      DocumentSnapshot dc = await FirebaseFirestore.instance
          .collection("datacards")
          .doc(dcUID)
          .get();
      datacardList.add(Datacard.fromJson(dc.data() as Map<String, dynamic>));
    }
    return datacardList;
  }

  updateUser() async {
    UpdateController updateController = Get.find<UpdateController>();
    HomeController homeController = Get.find<HomeController>();
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    updateController.loading.value = true;
    String imageLink = updateController.imageLink;
    if (updateController.imageSelected.value) {
      final path = 'user-profiles/${updateController.image.value.name}';
      final file = File(updateController.image.value.path);

      final ref = FirebaseStorage.instance.ref().child(path);
      UploadTask uploadTask = ref.putFile(file);

      final snapshot = await uploadTask.whenComplete(() => null);

      final url = await snapshot.ref.getDownloadURL();
      imageLink = url;
    }
    User user = firebaseAuth.currentUser!;
    user.updateDisplayName(updateController.nameController.text);
    user.updateEmail(updateController.emailController.text);
    user.updatePhotoURL(imageLink);

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var updateData = {
      "name": updateController.nameController.text,
      "email": updateController.emailController.text,
      "aadharNumber": updateController.aadharController.text,
      "photoUrl": imageLink,
    };
    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .update(updateData);

    homeController.fetchUser();

    Get.snackbar(
      "Updated",
      "Your account has been updated successfully",
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
    updateController.loading.value = false;
    Get.offAllNamed(Routes.HOME);
  }

  //get user details by passing uid
  Future<userModel.User> getUserByUID(String uid) async {
    DocumentSnapshot user =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();
    return userModel.User.fromJson(user.data() as Map<String, dynamic>);
  }

  //update user's files
  Future updateUserData(String category, List<String> data) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    String uid = firebaseAuth.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .update({category: data});
  }
}
