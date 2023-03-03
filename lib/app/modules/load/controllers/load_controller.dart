import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datacard/app/modules/login/bindings/login_binding.dart';
import 'package:datacard/constants/app_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../login/views/register_view.dart';

class LoadController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    checkUser();
    fetchConfig();
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
        Get.offAllNamed(Routes.LOCK);
      }
    } else {
      Get.offAndToNamed(Routes.LOGIN);
    }
  }

  //fetch all the app's config details
  Future fetchConfig() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentSnapshot ec2Doc =
        await firebaseFirestore.collection("config").doc("ec2").get();
    var ec2Data = ec2Doc.data() as Map<String, dynamic>;
    AppConstants.domain = ec2Data["domain"];
    AppConstants.protocol = ec2Data["protocol"];
    AppConstants.port = ec2Data["port"];

    DocumentSnapshot serverDoc =
        await firebaseFirestore.collection("config").doc("server").get();
    var serverData = serverDoc.data() as Map<String, dynamic>;
    AppConstants.apiKey = serverData["api-key"];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
