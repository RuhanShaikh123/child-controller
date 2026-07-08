import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PairingDatasource {

  final FirebaseFirestore firestore =
      FirebaseFirestore.instance;

  final FirebaseAuth auth =
      FirebaseAuth.instance;

  Future<void> connect(String code) async {

    final pairDoc = await firestore
        .collection("pairing_codes")
        .doc(code)
        .get();

    if (!pairDoc.exists) {
      throw Exception("Invalid Pair Code");
    }

    final data = pairDoc.data()!;

    if (data["used"] == true) {
      throw Exception("Pair code already used");
    }

    final Timestamp expires =
    data["expiresAt"];

    if (expires.toDate().isBefore(DateTime.now())) {
      throw Exception("Pair code expired");
    }

    final childUid = auth.currentUser!.uid;

    final parentUid = data["parentUid"];

    final familyId = data["familyId"];

    final batch = firestore.batch();

    //--------------------------------------------------
    // Update Child
    //--------------------------------------------------

    batch.update(

      firestore
          .collection("users")
          .doc(childUid),

      {

        "parentUid": parentUid,

        "familyId": familyId,

        "paired": true,

      },

    );

    //--------------------------------------------------
    // Update Parent
    //--------------------------------------------------

    batch.update(

      firestore
          .collection("users")
          .doc(parentUid),

      {

        "childUid": childUid,

        "paired": true,

      },

    );

    //--------------------------------------------------
    // Update Family
    //--------------------------------------------------

    batch.update(

      firestore
          .collection("families")
          .doc(familyId),

      {

        "childUid": childUid,

        "paired": true,

      },

    );

    //--------------------------------------------------
    // Disable Pair Code
    //--------------------------------------------------

    batch.update(

      firestore
          .collection("pairing_codes")
          .doc(code),

      {

        "used": true,

        "childUid": childUid,

        "usedAt": FieldValue.serverTimestamp(),

      },

    );

    await batch.commit();

  }

}