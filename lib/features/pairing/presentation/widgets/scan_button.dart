import 'package:flutter/material.dart';

class ScanButton extends StatelessWidget {
  final VoidCallback onTap;

  const ScanButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: const Icon(Icons.qr_code_scanner),
        label: const Text(
          "Scan QR Code",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}