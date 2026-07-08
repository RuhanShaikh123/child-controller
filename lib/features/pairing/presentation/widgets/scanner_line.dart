import 'package:flutter/material.dart';

class ScannerLine extends StatefulWidget {
  const ScannerLine({super.key});

  @override
  State<ScannerLine> createState() => _ScannerLineState();
}

class _ScannerLineState extends State<ScannerLine>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,

      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 260,

        height: 260,

        child: AnimatedBuilder(
          animation: controller,

          builder: (_, child) {
            return Stack(
              children: [
                Positioned(
                  top: controller.value * 240,

                  left: 0,

                  right: 0,

                  child: Container(height: 3, color: Colors.greenAccent),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
