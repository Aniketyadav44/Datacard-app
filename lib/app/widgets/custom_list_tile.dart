import 'package:flutter/material.dart';

import '../../constants/color_constants.dart';

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  const CustomListTile({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 30,
      ),
      title: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      tileColor: ColorConstants.secondaryColor,
      iconColor: Colors.white,
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 30,
      ),
      onTap: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
    );
  }
}
