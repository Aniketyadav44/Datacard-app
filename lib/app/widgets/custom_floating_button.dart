import 'package:flutter/material.dart';

import 'package:datacard/constants/color_constants.dart';

class CustomFloatingButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  CustomFloatingButton({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: 70,
      child: FloatingActionButton(
        backgroundColor: ColorConstants.secondaryColor,
        onPressed: onPressed,
        child: Icon(
          icon,
          color: Colors.white,
          size: 35,
        ),
      ),
    );
  }
}
