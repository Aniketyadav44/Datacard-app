import 'package:cloud_firestore/cloud_firestore.dart';

class Document {
  final String name;
  final String description;
  final String type;
  final String encryptedCID;
  final String uid;
  final DateTime addedOn;
  final String owner;

  Document({
    required this.name,
    required this.description,
    required this.type,
    required this.encryptedCID,
    required this.uid,
    required this.addedOn,
    required this.owner,
  });

  static Document fromJson(Map<String, dynamic> json) {
    return Document(
      name: json['name'],
      description: json['description'],
      type: json['type'],
      encryptedCID: json['encryptedCID'],
      uid: json['uid'],
      addedOn: (json['addedOn'] as Timestamp).toDate(),
      owner: json['owner'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'type': type,
      'encryptedCID': encryptedCID,
      'uid': uid,
      'addedOn': Timestamp.fromDate(addedOn),
      'owner': owner,
    };
  }

  static Document initialize() {
    return Document(
      name: '',
      description: '',
      type: '',
      encryptedCID: '',
      uid: '',
      addedOn: DateTime.now(),
      owner: '',
    );
  }
}
