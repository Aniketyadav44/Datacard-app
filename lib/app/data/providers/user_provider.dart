import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart' as userModel;

class UserProvider {
  //get user details
  Future<userModel.User> fetchUser() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    String uid = firebaseAuth.currentUser!.uid;
    DocumentSnapshot user =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();
    return userModel.User.fromJson(user.data() as Map<String, dynamic>);
  }
}
