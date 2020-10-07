import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';

class ViewPDF extends StatelessWidget {
  final PDFDocument doc;
  ViewPDF({
    @required this.doc,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Example'),
      ),
      body: Center(child: PDFViewer(document: doc)),
    );
  }
}
