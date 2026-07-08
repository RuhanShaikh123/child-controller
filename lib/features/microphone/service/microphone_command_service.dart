import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'microphone_service.dart';

class MicrophoneCommandService {
  StreamSubscription? _sub;
  bool _running = false;

  void start(String familyId) {
    _sub?.cancel();

    _sub = FirebaseFirestore.instance
        .collection("families")
        .doc(familyId)
        .snapshots()
        .listen((doc) async {
      if (!doc.exists) return;

      final data = doc.data();
      if (data == null) return;

      final commands = Map<String, dynamic>.from(data["commands"] ?? {});
      final micActive = commands["microphone"] == true;

      if (micActive && !_running) {
        _running = true;
        debugPrint("🎤 Child microphone activated");
        await MicrophoneService().startService(familyId);
      }

      if (!micActive && _running) {
        _running = false;
        debugPrint("🛑 Child microphone stopped");
        await MicrophoneService().stopService();
      }
    });
  }

  void stop() {
    _sub?.cancel();
  }
}