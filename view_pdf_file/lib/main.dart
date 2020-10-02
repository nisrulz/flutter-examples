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
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        PDFDocument doc =
                            await PDFDocument.fromAsset('assets/Hello.pdf');
                        setState(() {
                          isLoading = false;
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ViewPDF(doc: doc),
                          ),
                        );
                      },
                      child: Text("Load local PDF"),
                    ),
                    RaisedButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });

                        ///Update pdf URL from `constansts.dart`
                        ///change argument passed as per branch
                        PDFDocument doc =
                            await PDFDocument.fromURL(Constants.testURL);
                        setState(() {
                          isLoading = false;
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ViewPDF(doc: doc),
                          ),
                        );
                      },
                      child: Text("Load PDF via URL"),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
