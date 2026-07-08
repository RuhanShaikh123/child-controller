import 'package:flutter/services.dart';

class UsageChannel {
  static const MethodChannel _channel =
  MethodChannel("child_controller/accessibility");

  static Future<void> openUsageAccess() async {
    await _channel.invokeMethod("openUsageAccess");
  }

  static Future<bool> isUsageAccessEnabled() async {
    return await _channel.invokeMethod("isUsageAccessEnabled");
  }
}