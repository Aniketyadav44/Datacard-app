import 'package:flutter/material.dart';

import 'package:datacard/constants/color_constants.dart';

class CustomChoiceChip extends StatelessWidget {
  final bool selected;
  final VoidCallback onSelected;
  final String text;
  const CustomChoiceChip({
    Key? key,
    required this.selected,
    required this.onSelected,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: selected
              ? ColorConstants.secondaryColor
              : ColorConstants.darkBackgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selected ? Colors.white : ColorConstants.secondaryTextColor,
          ),
        ),
      ),
    );
  }
}
