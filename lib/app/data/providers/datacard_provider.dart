import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datacard/app/data/models/datacard_model.dart';
import 'package:datacard/app/data/providers/user_provider.dart';
import 'package:datacard/app/modules/datacard/controllers/datacard_controller.dart';
import 'package:datacard/app/modules/home/controllers/home_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DatacardProvider {
  createDatacard({
    required String name,
    required String description,
    required List<String> files,
  }) async {
    DatacardController datacardController = Get.find<DatacardController>();
    datacardController.loading(true);
    Map<String, dynamic> data = {
      'name': name,
      'description': description,
      'files': files,
      'uid': '',
      'access': false,
      'addedOn': DateTime.now(),
      'owner': FirebaseAuth.instance.currentUser!.uid,
    };
    //adding to firestore
    CollectionReference datacardRef =
        FirebaseFirestore.instance.collection("datacards");

    //updating uid of file on firestore
    await datacardRef.add(data).then((value) async {
      datacardRef.doc(value.id).update({'uid': value.id});
      Datacard newDatacard = Datacard(
        name: name,
        description: description,
        uid: value.id,
        addedOn: DateTime.now(),
        owner: FirebaseAuth.instance.currentUser!.uid,
        files: files,
      );

      //making local changes
      HomeController homeController = Get.find<HomeController>();
      homeController.userDatacards.add(newDatacard);

      //updating user's details
      List<String> userDatacards = homeController.user.value.datacards;
      userDatacards.add(value.id);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'datacards': userDatacards});
      homeController.user.value = await UserProvider().fetchUser();
    });
    datacardController.loading(false);
    Get.back();
    Get.snackbar(
      "Created",
      "Your datacard with name \"$name\" has been created successfully",
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future editDatacard(
    String uid,
    String name,
    String desc,
    List<String> files,
  ) async {
    await FirebaseFirestore.instance.collection("datacards").doc(uid).update({
      'name': name,
      'description': desc,
      'files': files,
    });
  }

  Future deleteDatacard(String uid) async {
    await FirebaseFirestore.instance.collection("datacards").doc(uid).delete();
  }

  Future<Map<String, dynamic>> getDatacard(String uid) async {
    DocumentSnapshot dcSnapshot =
        await FirebaseFirestore.instance.collection("datacards").doc(uid).get();
    return dcSnapshot.data() as Map<String, dynamic>;
  }
}
