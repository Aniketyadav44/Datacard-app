import 'package:datacard/constants/color_constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double height;
  final double textSize;
  final bool isBoldText;
  final Color color;
  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.height = 56.0,
    this.textSize = 18.0,
    this.isBoldText = true,
    this.color = ColorConstants.secondaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: color,
        ),
        child: Text(
          style: TextStyle(
            fontSize: textSize,
            fontWeight: isBoldText ? FontWeight.bold : FontWeight.normal,
          ),
          text,
        ),
      ),
    );
  }
}
