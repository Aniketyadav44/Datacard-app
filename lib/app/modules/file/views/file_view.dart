import 'dart:io';

import 'package:datacard/app/routes/app_pages.dart';
import 'package:datacard/app/widgets/loading_widget.dart';
import 'package:datacard/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import 'package:get/get.dart';

import '../controllers/file_controller.dart';

class FileView extends GetView<FileController> {
  FileController fileController = Get.find<FileController>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.offAllNamed(Routes.HOME);
        File(fileController.fileLoc.value).deleteSync();
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () => Get.offAllNamed(Routes.HOME),
          ),
          title: Obx(() => Text(fileController.documentName.value)),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Obx(
            () => fileController.loading.value
                ? LoadingWidget()
                : Padding(
                    padding: AppConstants.appPadding,
                    child: fileController.documentType.value == "image"
                        ? Center(
                            child: Image.network(
                                "https://ipfs.io/ipfs/${fileController.fileCID}"),
                          )
                        : fileController.documentType.value == "text"
                            ? Center(
                                child: Text(
                                  fileController.fileText.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : Center(
                                child: PDFView(
                                  filePath: fileController.fileLoc.value,
                                  enableSwipe: true,
                                  autoSpacing: false,
                                  pageFling: true,
                                  pageSnap: true,
                                ),
                              ),
                  ),
          ),
        ),
      ),
    );
  }
}
