import 'dart:io';

import 'package:datacard/app/data/models/document_model.dart';
import 'package:datacard/constants/app_constants.dart';
import 'package:get/get.dart';

class DocumentProvider extends GetConnect {
  @override
  void onInit() {
    var link =
        "${AppConstants.protocol}://${AppConstants.domain}:${AppConstants.port}";
    httpClient.baseUrl = link;
  }

  //function to upload document
  uploadDocument(
      {required String name,
      required String description,
      required String fileType,
      required File document}) async {
    var newDocData = {
      "name": name,
      "description": description,
      "type": fileType,
      "encryptedCID": "",
      "uid": "",
      "access": false,
    };
    print("This is new doc: $newDocData");
    Document newDocument = Document(
      name: name,
      description: description,
      type: fileType,
      encryptedCID: "",
      uid: "",
    );
  }
}
