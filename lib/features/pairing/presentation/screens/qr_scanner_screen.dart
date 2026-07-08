import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:vibration/vibration.dart';
import '../widgets/scanner_line.dart';
import '../widgets/scanner_overlay.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final MobileScannerController controller = MobileScannerController();

  bool scanned = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (scanned) return;

    final Barcode barcode = capture.barcodes.first;

    final String? code = barcode.rawValue;

    if (code == null) return;

    scanned = true;

    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 150);
    }

    if (mounted) {
      context.pop(code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: Stack(
        children: [
          MobileScanner(controller: controller, onDetect: _onDetect),

          const ScannerOverlay(),

          const ScannerLine(),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),

                const Text(
                  "Scan Parent QR Code",

                  style: TextStyle(
                    color: Colors.white,

                    fontSize: 24,

                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Align the QR code inside the frame",

                  style: TextStyle(color: Colors.white70),
                ),

                const Spacer(),

                Padding(
                  padding: const EdgeInsets.only(bottom: 40),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children: [
                      FloatingActionButton(
                        heroTag: "flash",

                        onPressed: () {
                          controller.toggleTorch();
                        },

                        child: const Icon(Icons.flash_on),
                      ),

                      FloatingActionButton(
                        heroTag: "camera",

                        onPressed: () {
                          controller.switchCamera();
                        },

                        child: const Icon(Icons.cameraswitch),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
