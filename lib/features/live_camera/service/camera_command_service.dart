import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'camera_service.dart';

class CameraCommandService {
  StreamSubscription? _sub;
  bool _running = false;

  void start(String familyId) {
    debugPrint("CAMERA LISTENER STARTED FOR FAMILY = $familyId");

    _sub?.cancel();

    _sub = FirebaseFirestore.instance
        .collection("families")
        .doc(familyId)
        .snapshots()
        .listen((doc) async {
      debugPrint("CAMERA FIRESTORE DOC CHANGED");

      if (!doc.exists) {
        debugPrint("CAMERA FAMILY DOC DOES NOT EXIST");
        return;
      }

      final data = doc.data();

      debugPrint("CAMERA DOC DATA = $data");

      if (data == null) return;

      final commands = Map<String, dynamic>.from(
        data["commands"] ?? {},
      );

      final cameraActive = commands["camera"] == true;

      debugPrint("CAMERA ACTIVE VALUE = $cameraActive");

      if (cameraActive && !_running) {
        _running = true;

        debugPrint("📷 Camera Activated");

        await CameraService().startService(familyId);
      }

      if (!cameraActive && _running) {
        _running = false;

        debugPrint("🛑 Camera Stopped");

        await CameraService().stopService();
      }
    });
  }

  void stop() {
    debugPrint("CAMERA LISTENER STOPPED");
    _sub?.cancel();
  }
}