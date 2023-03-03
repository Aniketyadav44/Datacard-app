class Document {
  final String name;
  final String description;
  final String type;
  final String encryptedCID;
  final String uid;

  Document({
    required this.name,
    required this.description,
    required this.type,
    required this.encryptedCID,
    required this.uid,
  });

  static Document fromJson(Map<String, dynamic> json) {
    return Document(
      name: json['name'],
      description: json['description'],
      type: json['type'],
      encryptedCID: json['encryptedCID'],
      uid: json['uid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'type': type,
      'encryptedCID': encryptedCID,
      'uid': uid,
    };
  }

  static Document initialize() {
    return Document(
      name: '',
      description: '',
      type: '',
      encryptedCID: '',
      uid: '',
    );
  }
}
