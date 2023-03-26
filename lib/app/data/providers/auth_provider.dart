import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datacard/app/data/local_storage.dart';
import 'package:datacard/app/data/models/user_model.dart' as userModel;
import 'package:datacard/app/modules/login/controllers/login_controller.dart';
import 'package:datacard/app/modules/login/views/register_view.dart';
import 'package:datacard/app/routes/app_pages.dart';
import 'package:datacard/constants/app_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthProvider {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //verify otp function when user enters otp
  verifyOTP(String otp, BuildContext context) async {
    LoginController loginController = Get.find<LoginController>();
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: loginController.verificationID,
      smsCode: otp,
    );

    UserCredential user = await firebaseAuth
        .signInWithCredential(credential)
        .catchError((error) async {
      loginController.loading.value = false;
      if (error.code == "invalid-verification-code") {
        Get.snackbar(
          "Error",
          "OTP entered was not valid!",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
        );
        loginController.loading.value = false;
      }
      return Future.error(error);
    });

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentSnapshot userDoc = await firebaseFirestore
        .collection("users")
        .doc(user.user!.uid.toString())
        .get();
    if (!userDoc.exists) {
      loginController.loading.value = false;
      Get.offAll(() => RegisterView());
    } else {
      var data = userDoc.data() as Map<String, dynamic>;
      LocalStorage().setKey(data['key']);
      loginController.loading.value = false;
      Get.offAllNamed(Routes.HOME);
    }
  }

  //register new user in firesotre
  registerUser() async {
    LoginController loginController = Get.find<LoginController>();
    loginController.loading.value = true;
    String imageLink = AppConstants.profileImage;
    if (loginController.imageSelected.value) {
      final path = 'user-profiles/${loginController.image.value.name}';
      final file = File(loginController.image.value.path);

      final ref = FirebaseStorage.instance.ref().child(path);
      UploadTask uploadTask = ref.putFile(file);

      final snapshot = await uploadTask.whenComplete(() => null);

      final url = await snapshot.ref.getDownloadURL();
      imageLink = url;
    }
    User user = firebaseAuth.currentUser!;
    user.updateDisplayName(loginController.nameController.text);
    user.updateEmail(loginController.emailController.text);
    user.updatePhotoURL(imageLink);

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    String mtoken = "";
    await FirebaseMessaging.instance.getToken().then((token) {
      mtoken = token!;
    });
    userModel.User newUser = userModel.User(
      name: loginController.nameController.text,
      email: loginController.emailController.text,
      phone: loginController.phoneController.text,
      aadharNumber: loginController.aadharNoController.text,
      photoUrl: imageLink,
      uid: user.uid,
      key: loginController.keyController.text,
      isVerified: false,
      mostUsed: [],
      recentlyViewed: [],
      files: [],
      datacards: [],
      token: mtoken,
    );
    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(newUser.toJson());
    Get.offAllNamed(Routes.HOME);
    LocalStorage().setKey(loginController.keyController.text);
    loginController.loading.value = false;
  }

  //funciton to login with phone
  loginWithPhone(String phoneNumber, BuildContext context) async {
    LoginController loginController = Get.find<LoginController>();
    firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential authCredential) async {
        await firebaseAuth.signInWithCredential(authCredential).then((result) {
          print(result);
        }).catchError((e) {
          print(e);
        });
      },
      verificationFailed: (FirebaseAuthException authException) {
        print(authException.message);
        Get.snackbar(
          "Error occured",
          authException.message.toString(),
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
        );
      },
      codeSent: (String verificationID, int? resendToken) async {
        Get.snackbar(
          "OTP sent",
          "The otp has been sent!",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
        );
        loginController.codeSent.value = true;
        loginController.verificationID = verificationID;
      },
      codeAutoRetrievalTimeout: (String verificationID) {},
    );
  }

  logout() async {
    await firebaseAuth.signOut();
  }
}
