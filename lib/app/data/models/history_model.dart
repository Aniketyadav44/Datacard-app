import 'package:cloud_firestore/cloud_firestore.dart';

class History {
  final String name;
  final String uid;
  final String ownerUID;
  final String personName;
  final String fileType;
  final String transferType;
  final DateTime date;

  History({
    required this.name,
    required this.uid,
    required this.ownerUID,
    required this.personName,
    required this.fileType,
    required this.transferType,
    required this.date,
  });

  static History fromJson(Map<String, dynamic> json) {
    return History(
      name: json['name'],
      uid: json['uid'],
      ownerUID: json['ownerUID'],
      personName: json['personName'],
      fileType: json['fileType'],
      transferType: json['transferType'],
      date: (json['date'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'uid': uid,
      'ownerUID': ownerUID,
      'personName': personName,
      'fileType': fileType,
      'transerType': transferType,
      'date': Timestamp.fromDate(date),
    };
  }

  static History initizalise() {
    return History(
      name: '',
      uid: '',
      ownerUID: '',
      personName: '',
      fileType: '',
      transferType: '',
      date: DateTime.now(),
    );
  }
}
