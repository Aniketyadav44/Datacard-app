import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datacard/app/modules/login/bindings/login_binding.dart';
import 'package:datacard/constants/app_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../login/views/register_view.dart';

class LoadController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    checkUser();
    requestPermission();
    fetchConfig();
    saveToken();
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
        Get.offAllNamed(Routes.LOCK, arguments: [Routes.HOME]);
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
    AppConstants.fcmKey = serverData["fcm-key"];
    AppConstants.serverTimout = serverData["server-timeout"];

    DocumentSnapshot appDoc =
        await firebaseFirestore.collection("config").doc("app").get();
    var appData = appDoc.data() as Map<String, dynamic>;

    AppConstants.faq = appData["faqs"];
  }

  //get notification permission
  requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  //get the user's token and save to firestore
  saveToken() async {
    await FirebaseMessaging.instance.getToken().then((token) async {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'token': token!});
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
