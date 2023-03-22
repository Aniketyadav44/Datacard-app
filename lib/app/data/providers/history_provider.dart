import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/history_model.dart' as history_model;

class HistoryProvider {
  //register in share history
  Future<void> registerShared({
    required String name,
    required String personName,
    required String fileType,
  }) async {
    Map<String, dynamic> data = {
      'name': name,
      'uid': 'uid',
      'ownerUID': FirebaseAuth.instance.currentUser!.uid,
      'personName': personName,
      'fileType': fileType,
      'transferType': 'to',
      'date': DateTime.now(),
    };
    await FirebaseFirestore.instance
        .collection("history")
        .add(data)
        .then((value) async {
      await FirebaseFirestore.instance
          .collection("history")
          .doc(value.id)
          .update({'uid': value.id});
    });
  }

  //register in received history
  Future<void> registerReceived({
    required String name,
    required String personName,
    required String fileType,
  }) async {
    Map<String, dynamic> data = {
      'name': name,
      'uid': 'uid',
      'ownerUID': FirebaseAuth.instance.currentUser!.uid,
      'personName': personName,
      'fileType': fileType,
      'transferType': 'from',
      'date': DateTime.now(),
    };

    await FirebaseFirestore.instance
        .collection("history")
        .add(data)
        .then((value) async {
      await FirebaseFirestore.instance
          .collection("history")
          .doc(value.id)
          .update({'uid': value.id});
    });
  }

  //get user's history
  Future<List<history_model.History>> getHistory(String type) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    var typeTransfer = type == "shared" ? "to" : "from";
    List<history_model.History> hist = [];
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("history")
        .where("ownerUID", isEqualTo: uid)
        .where("transferType", isEqualTo: typeTransfer)
        .orderBy('date', descending: true)
        .limit(20)
        .get();
    snap.docs.forEach((element) {
      hist.add(history_model.History.fromJson(
          element.data() as Map<String, dynamic>));
    });

    return hist;
  }
}
