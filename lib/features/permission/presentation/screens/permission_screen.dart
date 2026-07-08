import 'package:flutter/material.dart';
import '../../../live_camera/service/camera_command_service.dart';
import '../../../location/location_service_provider/location_service_provider.dart';
import '../../widget/permission_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/permission_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../microphone/service/microphone_command_service.dart';

class PermissionScreen extends ConsumerStatefulWidget {
  const PermissionScreen({super.key});

  @override
  ConsumerState<PermissionScreen> createState() =>
      _PermissionScreenState();
}

class _PermissionScreenState extends ConsumerState<PermissionScreen>


    with WidgetsBindingObserver{

  final MicrophoneCommandService micCommandService =
  MicrophoneCommandService();

  final CameraCommandService
  cameraCommandService =
  CameraCommandService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    Future.microtask(() async {
      final notifier = ref.read(permissionProvider.notifier);

      await notifier.initPermissions();

     // if (notifier.location) {
     //   await ref.read(locationServiceProvider).start();
   //   }

      final uid = FirebaseAuth.instance.currentUser!.uid;

      final userDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .get();

      final familyId = userDoc.data()?["familyId"];

      debugPrint("CHILD FAMILY ID = $familyId");

      if (familyId != null) {
        micCommandService.start(familyId);
        cameraCommandService.start(familyId);

        debugPrint("MIC COMMAND SERVICE STARTED");
        debugPrint("CAMERA COMMAND SERVICE STARTED");
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      final notifier = ref.read(permissionProvider.notifier);

      Future.microtask(() async {
        final notifier = ref.read(permissionProvider.notifier);

        await notifier.initPermissions();

        if (notifier.location) {
          await ref.read(locationServiceProvider).start();
        }

        final uid = FirebaseAuth.instance.currentUser!.uid;

        final userDoc = await FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .get();

        final familyId = userDoc.data()?["familyId"];

        if (familyId != null) {
          micCommandService.start(familyId);
        }
      });
    }
  }


  @override
  void dispose() {
    micCommandService.stop();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final grantedCount = ref.watch(permissionProvider);

    final notifier = ref.read(permissionProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Device Setup"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Icon(
                Icons.security,
                size: 80,
                color: Colors.blue,
              ),

              const SizedBox(height: 10),

              const Text(
                "Grant the required permissions to keep your child protected.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 20),

              LinearProgressIndicator(
                value: grantedCount / 10,
              ),

              const SizedBox(height: 10),

              Text(
                "$grantedCount / 10 Permissions Granted",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: ListView(
                  children: [

                    PermissionCard(
                      icon: Icons.accessibility,
                      title: "Accessibility Service",
                      subtitle: "Required to block apps",
                      granted: notifier.accessibility,
                      onTap: () async {
                        await notifier.openAccessibility();
                      },
                    ),

                    PermissionCard(
                      icon: Icons.bar_chart,
                      title: "Usage Access",
                      subtitle: "Track app usage",
                      granted: notifier.usageAccess,
                      onTap: () async {
                        await notifier.openUsageAccess();
                      },
                    ),

                    PermissionCard(
                      icon: Icons.notifications,
                      title: "Notification Access",
                      subtitle: "Read notifications",
                      granted: false,
                      onTap: () {},
                    ),

                    PermissionCard(
                      icon: Icons.layers,
                      title: "Overlay Permission",
                      subtitle: "Display over apps",
                      granted: false,
                      onTap: () {},
                    ),

                    PermissionCard(
                      icon: Icons.battery_charging_full,
                      title: "Battery Optimization",
                      subtitle: "Keep service alive",
                      granted: false,
                      onTap: () {},
                    ),

                    PermissionCard(
                      icon: Icons.admin_panel_settings,
                      title: "Device Administrator",
                      subtitle: "Prevent uninstall",
                      granted: false,
                      onTap: () {},
                    ),

                    PermissionCard(
                      icon: Icons.location_on,
                      title: "Location",
                      subtitle: "Track child location",
                      granted: notifier.location,
                      onTap: () async {
                        await notifier.requestLocation();
                      },
                    ),

                    PermissionCard(
                      icon: Icons.camera_alt,
                      title: "Camera",
                      subtitle: "Live Camera",
                      granted: notifier.camera,
                      onTap: () async {
                        await notifier.requestCamera();
                      },
                    ),

                    PermissionCard(
                      icon: Icons.mic,
                      title: "Microphone",
                      subtitle: "Live Audio",
                      granted: notifier.microphone,
                      onTap: () async {
                        await notifier.requestMicrophone();
                      },
                    ),

                    PermissionCard(
                      icon: Icons.screen_share,
                      title: "Screen Capture",
                      subtitle: "Live Screen Sharing",
                      granted: false,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

