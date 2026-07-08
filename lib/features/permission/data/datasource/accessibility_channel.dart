import 'package:flutter/services.dart';

class AccessibilityChannel {
  static const MethodChannel _channel =
  MethodChannel("child_controller/accessibility");

  static Future<void> openAccessibilitySettings() async {
    await _channel.invokeMethod("openAccessibility");
  }

  static Future<bool> isAccessibilityEnabled() async {
    final bool enabled =
    await _channel.invokeMethod("isAccessibilityEnabled");

    return enabled;
  }
}