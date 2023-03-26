import 'package:cloud_firestore/cloud_firestore.dart';

class AdminRequest {
  final String requesterUID;
  final String requestTitle;
  final String requestDesc;
  final DateTime requestTime;
  final String uid;

  AdminRequest({
    required this.requesterUID,
    required this.requestTitle,
    required this.requestDesc,
    required this.requestTime,
    required this.uid,
  });

  static AdminRequest fromJson(Map<String, dynamic> json) {
    return AdminRequest(
      requesterUID: json['requesterUID'],
      requestTitle: json['requestTitle'],
      requestDesc: json['requestDesc'],
      uid: json['uid'],
      requestTime: (json['requestTime'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'requesterUID': requesterUID,
      'requestTitle': requestTitle,
      'requestDesc': requestDesc,
      'requestTime': Timestamp.fromDate(requestTime),
      'uid': uid,
    };
  }

  static AdminRequest initialize() {
    return AdminRequest(
      requesterUID: '',
      requestTitle: '',
      requestDesc: '',
      uid: '',
      requestTime: DateTime.now(),
    );
  }
}
