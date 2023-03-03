import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/color_constants.dart';
import '../data/models/document_model.dart';

class DocumentTile extends StatelessWidget {
  final Document document;
  final bool detailed;
  final VoidCallback onEditTap;
  final VoidCallback onShareTap;
  const DocumentTile({
    Key? key,
    required this.document,
    this.detailed = true,
    required this.onEditTap,
    required this.onShareTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ColorConstants.darkBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: ColorConstants.borderColor,
        ),
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
              color: ColorConstants.secondaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            width: 50,
            height: 50,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: SvgPicture.asset(
                "assets/icons/${document.type == "image" ? "image_file" : document.type == "text" ? "text_file" : "pdf_file"}.svg",
              ),
            ),
          ),
          Text(
            document.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          if (detailed)
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: onShareTap,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        color: ColorConstants.blueColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: 40,
                      height: 40,
                      child: const Icon(
                        Icons.share,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: onEditTap,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        color: ColorConstants.yelloColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: 40,
                      height: 40,
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
