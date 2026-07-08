import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceService {
  Future<String> getDeviceName() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final android = await deviceInfo.androidInfo;
      return "${android.brand} ${android.model}";
    }

    if (Platform.isIOS) {
      final ios = await deviceInfo.iosInfo;
      return ios.name;
    }

    return "Unknown Device";
  }
}