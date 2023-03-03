import 'package:datacard/constants/app_constants.dart';

class User {
  final String name;
  final String email;
  final String phone;
  final String aadharNumber;
  final String photoUrl;
  final String uid;
  final bool isVerified;
  final List<String> mostUsed;
  final List<String> recentlyViewed;

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
      mostUsed: [],
      recentlyViewed: [],
    );
  }
}
