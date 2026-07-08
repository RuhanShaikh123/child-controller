import 'package:child_controller/features/permission/data/datasource/usage_channel.dart';
import 'package:permission_handler/permission_handler.dart';

import 'accessibility_channel.dart';

class PermissionDatasource {

  Future<void> openAccessibility() async {
    await AccessibilityChannel.openAccessibilitySettings();
  }

  Future<bool> isAccessibilityEnabled() async {
    return AccessibilityChannel.isAccessibilityEnabled();
  }

  Future<void> openUsageAccess() async {
    await UsageChannel.openUsageAccess();
  }

  Future<bool> isUsageAccessEnabled() async {
    return UsageChannel.isUsageAccessEnabled();
  }


  Future<bool> requestCamera() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  Future<bool> requestMicrophone() async {
    final status = await Permission.microphone.request();
    return status.isGranted;
  }

  Future<bool> requestLocation() async {
    final status = await Permission.location.request();
    return status.isGranted;
  }

  Future<bool> requestNotification() async {
    final status = await Permission.notification.request();
    return status.isGranted;
  }

}