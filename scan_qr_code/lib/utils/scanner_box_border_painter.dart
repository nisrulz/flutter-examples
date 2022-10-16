import 'package:flutter/material.dart';

class ScannerBoxBorderPainter extends CustomPainter {
  final Color borderColor;

  ScannerBoxBorderPainter({required this.borderColor});

  @override
  void paint(Canvas canvas, Size size) {
    double sh = size.height; // for convenient shortage
    double sw = size.width; // for convenient shortage
    double cornerSide = 78.0; // desirable value for corners side

    Paint paint = Paint()
      ..color = borderColor
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    Path path = Path()
      ..moveTo(cornerSide, 0)
      ..lineTo(0, 0)
      ..lineTo(0, cornerSide)
      ..moveTo(0, sh - cornerSide)
      ..lineTo(0, sh)
      ..lineTo(cornerSide, sh)
      ..moveTo(sw - cornerSide, sh)
      ..lineTo(sw, sh)
      ..lineTo(sw, sh - cornerSide)
      ..moveTo(sw, cornerSide)
      ..lineTo(sw, 0)
      ..lineTo(sw - cornerSide, 0)
      ..moveTo(cornerSide, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(ScannerBoxBorderPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(ScannerBoxBorderPainter oldDelegate) => false;
}
