import 'package:flutter/material.dart';

class ScannerOverlay extends StatelessWidget {
  const ScannerOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          Container(color: Colors.black54),

          Center(
            child: Container(
              width: 260,

              height: 260,

              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 4),

                borderRadius: BorderRadius.circular(20),

                color: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
