import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
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
  PDFDocument doc;

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
                    RaisedButton(
                      onPressed: () {
                        loadFromAsset();
                      },
                      child: Text("Load local PDF"),
                    ),
                    RaisedButton(
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
    doc = await PDFDocument.fromAsset('assets/Hello.pdf');
    setState(() {
      isLoading = false;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ViewPDF(doc: doc),
      ),
    );
  }

  loadFromURL() async {
    setState(() {
      isLoading = true;
    });

    doc = await PDFDocument.fromURL(Constants.pdfURL);
    setState(() {
      isLoading = false;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ViewPDF(doc: doc),
      ),
    );
  }
}
