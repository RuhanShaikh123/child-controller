import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LocationDatasource {

  final firestore = FirebaseFirestore.instance;

  final auth = FirebaseAuth.instance;

  Future<void> uploadLocation({
    required double latitude,
    required double longitude,
  }) async {

    final uid = auth.currentUser!.uid;

    await firestore
        .collection("users")
        .doc(uid)
        .update({

      "latitude": latitude,

      "longitude": longitude,

      "lastLocationUpdate": FieldValue.serverTimestamp(),

    });

  }
}