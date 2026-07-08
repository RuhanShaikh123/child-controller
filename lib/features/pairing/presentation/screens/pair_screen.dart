import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../devices/data/device_service.dart';
import '../providers/pairing_provider.dart';
import '../widgets/code_input.dart';
import '../widgets/scan_button.dart';

class PairScreen extends ConsumerStatefulWidget {
  const PairScreen({super.key});

  @override
  ConsumerState<PairScreen>createState() => _PairScreenState();
}

class _PairScreenState extends ConsumerState<PairScreen> {
  final codeController = TextEditingController();

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Connect to Parent"),
        centerTitle: true,
      ),
      body:SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 30),

                const Icon(
                  Icons.devices,
                  size: 100,
                  color: Colors.blue,
                ),

                const SizedBox(height: 20),

                const Text(
                  "Connect Your Device",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Scan the QR code from the Parent app or enter the pairing code manually.",
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),

                ScanButton(
                  onTap: () async {

                    final result = await context.push<String>("/scanner");

                    if (result != null) {

                      codeController.text = result;

                    }

                  },
                ),

                const SizedBox(height: 25),

                const Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text("OR"),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),

                const SizedBox(height: 25),

                CodeInput(
                  controller: codeController,
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: FilledButton(
                    onPressed: () async {

                      final success = await ref
                          .read(pairingProvider.notifier)
                          .connect(codeController.text.trim());

                      if (success && context.mounted) {

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Device Connected Successfully"),
                          ),
                        );

                        final deviceName = await DeviceService().getDeviceName();

                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update({
                          "deviceName": deviceName,
                        });

                        context.go("/permission");
                      } else {

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              ref.read(pairingProvider.notifier).error ??
                                  "Connection Failed",
                            ),
                          ),
                        );

                      }
                    },
                    child: const Text("Connect Device"),
                  )
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}