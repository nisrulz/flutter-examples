import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';

class ViewPDF extends StatelessWidget {
  final String path;
  final String pdfName;
  ViewPDF({
    @required this.path,
    @required this.pdfName,
  });

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        appBar: AppBar(
          title: Text("$pdfName"),
        ),
        path: path);
  }
}
