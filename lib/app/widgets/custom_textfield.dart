import 'package:datacard/constants/color_constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final int maxLines;
  Widget? prefixIcon;
  TextInputType? keyboardType;
  CustomTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.maxLines = 1,
    this.prefixIcon,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: ColorConstants.secondaryTextColor),
        filled: true,
        fillColor: ColorConstants.darkBackgroundColor,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        prefixIcon: prefixIcon,
      ),
      validator: (val) {
        if (val == null) {
          return 'Please enter $hintText';
        }
        return null;
      },
    );
  }
}
