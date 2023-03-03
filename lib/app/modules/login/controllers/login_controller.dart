import 'package:datacard/app/data/providers/auth_provider.dart';
import 'package:datacard/app/modules/login/views/otp_view.dart';
import 'package:datacard/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class LoginController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController aadharNoController = TextEditingController();
  final registerFormKey = GlobalKey<FormState>();
  var showPass = false.obs;
  var loading = false.obs;
  var codeSent = false.obs;
  var agreeTerms = false.obs;

  String verificationID = "";

  Rx<XFile> image = XFile("").obs;
  var imageSelected = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  //pick image function
  pickImage() async {
    ImagePicker picker = ImagePicker();
    image.value = (await picker.pickImage(source: ImageSource.gallery))!;
    imageSelected(true);
  }

  //register new user
  register() {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        aadharNoController.text.isEmpty) {
      Get.snackbar(
        "Required",
        "All the fields are required!",
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else if (!emailController.text.isEmail) {
      Get.snackbar(
        "Invalid Email",
        "Please enter a valid email!",
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else if (aadharNoController.text.length != 12) {
      Get.snackbar(
        "Invalid Aadhar No.",
        "Please enter a valid aadhar number!",
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      AuthProvider authProvider = AuthProvider();
      authProvider.registerUser();
    }
  }

  //signin function
  signinUser(BuildContext context) {
    AuthProvider authProvider = AuthProvider();

    if (phoneController.text.length < 10) {
      Get.snackbar(
        "Invalid",
        "Please enter a valid phone number!",
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      authProvider.loginWithPhone("+91" + phoneController.text, context);
      Get.to(OtpView());
    }
  }

  //verify otp
  verifyOTP(context) {
    AuthProvider authProvider = AuthProvider();

    if (otpController.text.length < 6) {
      Get.snackbar(
        "Invalid",
        "Please enter a valid 6 digit OTP number!",
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      authProvider.verifyOTP(otpController.text, context);
    }
  }

  //logout function
  logoutUser() {
    AuthProvider authProvider = AuthProvider();
    authProvider.logout();
    Get.offAllNamed(Routes.LOGIN);
  }

  @override
  void onClose() {}
}
