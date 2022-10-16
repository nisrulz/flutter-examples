import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:scan_qr_code/utils/qr_code_scanner.dart';
import 'package:scan_qr_code/utils/scanner_box_border_painter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Code Scanner',
      home: MyHomePage(title: 'Code Scanner Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final MobileScannerController _mobileScannerController = MobileScannerController();
  late Function(Barcode barcode, MobileScannerArguments? args) _onDetect;
  bool _isScanning = true;

  @override
  void initState() {
    super.initState();
    _onDetect = (Barcode barcode, MobileScannerArguments? args) {
      _mobileScannerController.stop();
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Code info'),
              content: Text(barcode.rawValue?.trim() ?? 'No data found', textAlign: TextAlign.center),
              actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
            );
          }).then((value) {
        _mobileScannerController.start();
        setState(() {
          _isScanning = true;
        });
      });

      setState(() {
        _isScanning = false;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: SizedBox.square(
          dimension: MediaQuery.of(context).size.width - 48.0,
          child: Padding(
            padding: const EdgeInsets.all(2.5), // Required otherwise side edges hides under outside padding
            child: CustomPaint(
              foregroundPainter: ScannerBoxBorderPainter(borderColor: _isScanning ? Colors.black : Colors.green),
              child: Padding(
                padding: const EdgeInsets.all(2.5), // Required otherwise scanner hides under side edges
                child: QRCodeScanner(mobileScannerController: _mobileScannerController, allowDuplicates: false, onDetect: _onDetect),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
