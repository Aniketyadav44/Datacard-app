import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datacard/app/data/models/datacard_model.dart';
import 'package:datacard/app/data/models/document_model.dart';
import 'package:datacard/app/data/models/user_model.dart';
import 'package:datacard/app/data/providers/history_provider.dart';
import 'package:datacard/app/data/providers/request_provider.dart';
import 'package:datacard/app/modules/receive/views/staging_view.dart';
import 'package:datacard/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ReceiveController extends GetxController {
  Barcode? result;
  QRViewController? qrViewController;
  var loading = false.obs;
  var message = "Scan QR to Receive".obs;
  var msgSize = 20.obs;
  var reqLoading = false.obs;

  var type = "".obs;
  var uid = "".obs;
  var key = "".obs;
  var sharedTime = "".obs;

  Rx<Document> doc = Document.initialize().obs;
  Rx<Datacard> dc = Datacard.initialize().obs;
  Rx<User> sharer = User.initialize().obs;

  Map<String, dynamic> receivedData = {};

  var counter = 0.obs;
  Timer? _timer;
  var timeMsg = "Requesting for file...".obs;

  @override
  void onInit() {
    super.onInit();
  }

  void onQRViewCreated(QRViewController controller) {
    qrViewController = controller;

    controller.scannedDataStream.listen((scanData) {
      result = scanData;
      print("code: ${result!.code}");

      try {
        List<int> convertedString = json.decode(result!.code!).cast<int>();
        var decodedString = utf8.decode(convertedString);
        var dataList = decodedString.split('.');

        type.value = dataList[0];
        uid.value = dataList[1];
        key.value = dataList[2];
        sharedTime.value = dataList[3];

        print("Shared time: ${sharedTime.value}");

        loadDetails();
        Get.off(() => StagingView());
      } catch (e) {
        print("Eror:$e");
        message.value = "Please scan a QR of this app only";
        msgSize.value = 16;
      }
    });
  }

  loadDetails() async {
    loading(true);
    String collection = type.value == "dc" ? "datacards" : "files";
    String ownerUID = "";
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection(collection)
        .doc(uid.value)
        .get();
    if (type == "dc") {
      dc.value = Datacard.fromJson(snap.data() as Map<String, dynamic>);
      ownerUID = dc.value.owner;
    } else {
      doc.value = Document.fromJson(snap.data() as Map<String, dynamic>);
      ownerUID = doc.value.owner;
    }
    DocumentSnapshot userSnap = await FirebaseFirestore.instance
        .collection("users")
        .doc(ownerUID)
        .get();
    sharer.value = User.fromJson(userSnap.data() as Map<String, dynamic>);
    loading(false);
  }

  startTimer() {
    counter.value = 59;
    timeMsg.value = "Requesting for file...";
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, (timer) {
      if (counter.value == 0) {
        _timer!.cancel();
        Get.snackbar(
          "Timed Out",
          "Your request timed out!",
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        timeMsg.value = "Request timed out!, please try again.";
      } else {
        counter.value = counter.value - 1;
        print(counter.value);
      }
    });
  }

  requestAccess(ReceiveController receiveController) async {
    //check if server is up by pinging to the server
    loading(true);
    bool isServerUp = await RequestProvider().pingServer();
    if (!isServerUp) {
      loading(false);
      return;
    }
    loading(false);
    startTimer();
    receivedData = await RequestProvider().request(
      type.value,
      uid.value,
      doc.value,
      dc.value,
      sharer.value.token,
      key.value,
      receiveController,
    );

    if (receivedData != {} && !receivedData.containsKey("error")) {
      _timer!.cancel();
      counter.value = 0;
      //turning back the access of data to false
      var collectionName = type.value == "dc" ? "datacards" : "files";
      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(uid.value)
          .update({'access': false});

      //registering in received history
      await HistoryProvider().registerReceived(
        name: type.value == "dc" ? dc.value.name : doc.value.name,
        personName: sharer.value.name,
        fileType: type.value == "dc" ? "Data Card" : "Document",
      );
      Get.lazyPut(() => ReceiveController());
      if (type.value == "dc") {
        Get.offAllNamed(Routes.RECEIVED_DATACARD, arguments: [receivedData]);
      } else {
        Get.offAllNamed(Routes.RECEIVED_DOCUMENT, arguments: [receivedData]);
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    qrViewController!.dispose();
    _timer!.cancel();
  }
}
