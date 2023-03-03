import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datacard/app/modules/login/bindings/login_binding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../login/views/register_view.dart';

class LoadController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    checkUser();
  }

  //check for user's authorization
  Future checkUser() async {
    if (await FirebaseAuth.instance.currentUser != null) {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      DocumentSnapshot userDoc = await firebaseFirestore
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid.toString())
          .get();
      if (!userDoc.exists) {
        Get.off(() => RegisterView(), binding: LoginBinding());
      } else {
        Get.offAllNamed(Routes.HOME);
      }
    } else {
      Get.offAndToNamed(Routes.LOGIN);
    }
  }

  //fetch all the app's config details

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
