import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _loading;
  PDFDocument _doc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadDocument();
  }
  void loadDocument() async {
    setState(() {
      _loading = true;
    });
    final doc = await PDFDocument.fromAsset("assets/sample.pdf");
    setState(() {
      _doc = doc;
      _loading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Pdf Viewer"),
      ),
      body: _loading ?Center(child: CircularProgressIndicator(),):PDFViewer(document: _doc,),
    );
  }
}
