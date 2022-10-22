import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRCodeScanner extends StatelessWidget {
  final MobileScannerController mobileScannerController;
  final bool allowDuplicates;
  final Function(Barcode barcode, MobileScannerArguments? args) onDetect;
  const QRCodeScanner({Key? key, required this.mobileScannerController,required this.allowDuplicates, required this.onDetect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      allowDuplicates: allowDuplicates,
      controller: mobileScannerController,
      onDetect: onDetect,
    );
  }
}
