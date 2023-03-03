import 'package:datacard/app/data/models/user_model.dart';
import 'package:datacard/app/data/providers/user_provider.dart';
import 'package:datacard/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UpdateController extends GetxController {
  //TODO: Implement UpdateController
  HomeController homeController = Get.find<HomeController>();
  User? user;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController aadharController = TextEditingController();

  var loading = false.obs;

  var imageLink;

  Rx<XFile> image = XFile("").obs;
  var imageSelected = false.obs;
  @override
  void onInit() {
    super.onInit();
    user = homeController.user.value;
    nameController.text = user!.name;
    emailController.text = user!.email;
    aadharController.text = user!.aadharNumber;
    imageLink = user!.photoUrl;
  }

  //pick image function
  pickImage() async {
    ImagePicker picker = ImagePicker();
    image.value = (await picker.pickImage(source: ImageSource.gallery))!;
    imageSelected(true);
  }

  //update user info
  updateUser() async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        aadharController.text.isEmpty) {
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
    } else if (aadharController.text.length != 12) {
      Get.snackbar(
        "Invalid Aadhar No.",
        "Please enter a valid aadhar number!",
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      UserProvider userProvider = UserProvider();
      userProvider.updateUser();
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
