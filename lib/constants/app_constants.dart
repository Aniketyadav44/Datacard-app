import 'package:flutter/material.dart';

import 'color_constants.dart';

class AppConstants {
  static const authPadding = EdgeInsets.all(25);
  static const appPadding = EdgeInsets.all(20);
  static const screenHeading = 25.0;
  static const screenSubHeading = 20.0;

  static const otpOpenImg = 'assets/images/otp-open.png';
  static const otpLock = 'assets/images/icon-lock.png';
  static const profileAvatar = 'assets/images/profile-avatar.png';
  static const logoPurple = 'assets/icons/datacard-logo-purple.svg';
  static const logoPurplePng = 'assets/icons/datacard-logo-purple.png';
  static const logoBlack = 'assets/icons/datacard-logo-black.svg';
  static const errorImg = 'assets/icons/error.svg';

  static const profileImage =
      'https://firebasestorage.googleapis.com/v0/b/data-card-dd8ce.appspot.com/o/profile_avatar.png?alt=media&token=a09feeb0-e77d-4dc2-a310-fbdfda84e71d';

  static String domain = "";
  static String port = "";
  static String protocol = "";
  static String apiKey = "";
  static String fcmKey = "";
  static String serverTimout = "";

  static const String uploadFilePath = '/api/upload/file';
  static const String requestFilePath = '/api/request/file';
  static const String requestDataCardPath = '/api/request/data-card';
  static const String decryptCIDPath = '/api/request/decrypt';
  static const String pingGetPath = '/';

  static BoxDecoration customBoxDecoration = BoxDecoration(
    color: ColorConstants.darkBackgroundColor,
    border: Border.all(
      color: ColorConstants.borderColor,
    ),
    borderRadius: BorderRadius.circular(
      10,
    ),
  );
}
