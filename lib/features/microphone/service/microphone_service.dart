import 'package:flutter/services.dart';

class MicrophoneService {
  static const MethodChannel _channel =
  MethodChannel("child_controller/accessibility");

  Future<void> startService(String familyId) async {
    await _channel.invokeMethod(
      "startMicrophoneService",
      {
        "familyId": familyId,
      },
    );
  }

  Future<void> stopService() async {
    await _channel.invokeMethod(
      "stopMicrophoneService",
    );
  }
}