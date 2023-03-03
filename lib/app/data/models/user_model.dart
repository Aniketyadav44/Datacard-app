import 'package:datacard/constants/app_constants.dart';

class User {
  final String name;
  final String email;
  final String phone;
  final String aadharNumber;
  final String photoUrl;
  final String uid;
  final bool isVerified;
  final String key;
  final List<String> mostUsed;
  final List<String> recentlyViewed;
  final List<String> files;

  User({
    required this.name,
    required this.email,
    required this.phone,
    required this.aadharNumber,
    required this.photoUrl,
    required this.uid,
    required this.isVerified,
    required this.mostUsed,
    required this.recentlyViewed,
    required this.files,
    required this.key,
  });

  static User fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      aadharNumber: json['aadharNumber'],
      photoUrl: json['photoUrl'],
      uid: json['uid'],
      isVerified: json['isVerified'],
      mostUsed: json['mostUsed'].cast<String>(),
      recentlyViewed: json['recentlyViewed'].cast<String>(),
      files: json['files'].cast<String>(),
      key: json['key'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'aadharNumber': aadharNumber,
      'photoUrl': photoUrl,
      'uid': uid,
      'isVerified': isVerified,
      'mostUsed': mostUsed,
      'recentlyViewed': recentlyViewed,
      'files': files,
      'key': key,
    };
  }

  static User initialize() {
    return User(
      name: '',
      email: '',
      phone: '',
      aadharNumber: '',
      photoUrl: AppConstants.profileImage,
      uid: '',
      isVerified: false,
      key: '',
      mostUsed: [],
      recentlyViewed: [],
      files: [],
    );
  }
}
