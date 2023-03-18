import 'package:datacard/constants/color_constants.dart';
import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  final String title;
  final bool isChecked;
  final void Function(bool?) onChanged;
  const CustomCheckBox(
      {Key? key,
      required this.title,
      required this.isChecked,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: ColorConstants.backgroundColor,
      ),
      child: CheckboxListTile(
        contentPadding: EdgeInsets.only(left: 20, right: 5),
        activeColor: Colors.transparent,
        checkColor: ColorConstants.secondaryColor,
        side: isChecked
            ? MaterialStateBorderSide.resolveWith(
                (states) =>
                    BorderSide(width: 2, color: ColorConstants.secondaryColor),
              )
            : BorderSide(width: 2, color: ColorConstants.textColor),
        title: Text(
          title,
          style: TextStyle(
            color: ColorConstants.textColor,
            fontWeight: FontWeight.w400,
            fontSize: 17,
          ),
        ),
        value: isChecked,
        onChanged: onChanged,
        checkboxShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}
