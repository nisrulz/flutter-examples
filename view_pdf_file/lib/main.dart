import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:view_pdf_file/constants.dart';
import 'package:view_pdf_file/viewPDF.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'View PDF File',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  late Widget pdfViewer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View PDF File"),
      ),
      body: Container(
        child: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        loadFromAsset();
                      },
                      child: Text("Load local PDF"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        loadFromURL();
                      },
                      child: Text("Load PDF via URL"),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  loadFromAsset() async {
    setState(() {
      isLoading = true;
    });
    pdfViewer = SfPdfViewer.asset('assets/Hello.pdf');
    setState(() {
      isLoading = false;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ViewPDF(viewer: pdfViewer),
      ),
    );
  }

  loadFromURL() async {
    setState(() {
      isLoading = true;
    });

    pdfViewer = SfPdfViewer.network(Constants.pdfURL);
    setState(() {
      isLoading = false;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ViewPDF(viewer: pdfViewer),
      ),
    );
  }
}
