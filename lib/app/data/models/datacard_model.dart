import 'package:cloud_firestore/cloud_firestore.dart';

class Datacard {
  final String name;
  final String description;
  final String uid;
  final DateTime addedOn;
  final String owner;
  final List<String> files;

  Datacard({
    required this.name,
    required this.description,
    required this.uid,
    required this.addedOn,
    required this.owner,
    required this.files,
  });

  static Datacard fromJson(Map<String, dynamic> json) {
    return Datacard(
      name: json['name'],
      description: json['description'],
      uid: json['uid'],
      addedOn: (json['addedOn'] as Timestamp).toDate(),
      owner: json['owner'],
      files: json['files'].cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'uid': uid,
      'addedOn': Timestamp.fromDate(addedOn),
      'owner': owner,
      'files': files,
    };
  }

  static Datacard initialize() {
    return Datacard(
      name: '',
      description: '',
      uid: '',
      addedOn: DateTime.now(),
      owner: '',
      files: [],
    );
  }
}
