import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../devices/data/device_service.dart';
import '../../repository/permission_repository_provider.dart';

class PermissionNotifier extends StateNotifier<int> {
  PermissionNotifier(this.ref) : super(0);



  final Ref ref;
  bool accessibility = false;

  bool usageAccess = false;
  bool camera = false;
  bool microphone = false;
  bool location = false;

  Future<void> requestCamera() async {
    camera = await ref
        .read(permissionRepositoryProvider)
        .requestCamera();

    _update();
  }

  Future<void> initPermissions() async {

    camera = await Permission.camera.isGranted;
    microphone = await Permission.microphone.isGranted;
    location = await Permission.location.isGranted;

    accessibility = await ref
        .read(permissionRepositoryProvider)
        .isAccessibilityEnabled();

    usageAccess = await ref
        .read(permissionRepositoryProvider)
        .isUsageAccessEnabled();

    // Save device name
    final deviceName = await DeviceService().getDeviceName();

    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "deviceName": deviceName,
    });

    _update();
  }

  Future<void> openAccessibility() async {
    await ref
        .read(permissionRepositoryProvider)
        .openAccessibility();
  }

  Future<void> checkAccessibility() async {

    accessibility = await ref
        .read(permissionRepositoryProvider)
        .isAccessibilityEnabled();

    print("Accessibility: $accessibility");

    _update();
  }

  Future<void> openUsageAccess() async {
    await ref
        .read(permissionRepositoryProvider)
        .openUsageAccess();
  }

  Future<void> checkUsageAccess() async {

    usageAccess = await ref
        .read(permissionRepositoryProvider)
        .isUsageAccessEnabled();

    print("Usage Access: $usageAccess");

    _update();
  }


  Future<void> requestMicrophone() async {
    microphone = await ref
        .read(permissionRepositoryProvider)
        .requestMicrophone();

    _update();
  }

  Future<void> requestLocation() async {
    location = await ref
        .read(permissionRepositoryProvider)
        .requestLocation();

    _update();
  }

  void _update() {
    int count = 0;

    if (camera) count++;
    if (microphone) count++;
    if (location) count++;
    if (accessibility) count++;
    if (usageAccess) count++;

    state = count;
  }
}

final permissionProvider =
StateNotifierProvider<PermissionNotifier, int>((ref) {
  return PermissionNotifier(ref);
});