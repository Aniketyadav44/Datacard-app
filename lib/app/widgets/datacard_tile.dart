import 'package:datacard/app/data/models/datacard_model.dart';
import 'package:flutter/material.dart';

import '../../constants/color_constants.dart';

class DatacardTile extends StatelessWidget {
  final Datacard datacard;
  final bool detailed;
  final VoidCallback onEditTap;
  final VoidCallback onShareTap;
  final VoidCallback onTap;
  const DatacardTile(
      {Key? key,
      required this.datacard,
      this.detailed = true,
      required this.onEditTap,
      required this.onShareTap,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
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
            // Container(
            //   margin: const EdgeInsets.only(right: 10),
            //   decoration: BoxDecoration(
            //     border: Border.all(
            //       color: Colors.white,
            //       width: 2,
            //     ),
            //     color: ColorConstants.secondaryColor,
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            //   width: 50,
            //   height: 50,
            //   child: Padding(
            //     padding: const EdgeInsets.all(5),
            //     child: SvgPicture.asset(
            //       "assets/icons/${document.type == "image" ? "image_file" : document.type == "text" ? "text_file" : "pdf_file"}.svg",
            //     ),
            //   ),
            // ),
            Text(
              datacard.name,
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
      ),
    );
  }
}
