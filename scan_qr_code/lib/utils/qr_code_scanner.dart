import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRCodeScanner extends StatelessWidget {
  final MobileScannerController mobileScannerController;
  final void Function(BarcodeCapture) onDetect;
  const QRCodeScanner({
    super.key,
    required this.mobileScannerController,
    required this.onDetect,
  });

  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      controller: mobileScannerController,
      onDetect: onDetect,
    );
  }
}
