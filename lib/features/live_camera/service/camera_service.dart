import 'package:flutter/services.dart';

class CameraService {

  static const MethodChannel _channel =
  MethodChannel(
    "child_controller/camera",
  );

  Future<void> startService(
      String familyId,
      ) async {

    await _channel.invokeMethod(
      "startCameraService",
      {
        "familyId": familyId,
      },
    );
  }

  Future<void> stopService() async {

    await _channel.invokeMethod(
      "stopCameraService",
    );
  }
}