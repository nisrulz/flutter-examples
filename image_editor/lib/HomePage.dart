import 'package:flutter/material.dart';
import 'package:image_editor/ApplyFilters.dart';
import 'package:image_editor/EditImg.dart';
import 'package:image_editor/GetImg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_editor/SaveInGallery.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _selected = false; //to check if a image is selected or not
  File _image; //here we will store the selected image and apply modifications
  double _ImageContainerHeight=450, _ImageContainerWidth=400;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent[400],
        title: Text('Flutter Image Editor'),
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          Container(
              height: _ImageContainerHeight,
              width: _ImageContainerWidth,
              child: _selected // checks if a image is selected or not
                  ? Image.file(_image)
                  : Image.asset('images/cam.png')),
          Row(
            children: <Widget>[
              Spacer(
                flex: 2,
              ),
              RaisedButton(
                  color: Colors.greenAccent[400],
                  child: Text(
                    'Get_Image', // to select a image from gallery
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    var _Ifile = await GetiImg(_image); // function called from GetImg.dart
                    if (_Ifile != null) {
                      setState(() {
                        _image = _Ifile;
                        _selected = true;
                      });
                    }
                  }),
              Spacer(
                flex: 1,
              ),
              RaisedButton(
                  color: Colors.greenAccent[400],
                  child: Text(
                    'Edit Image', //to start editing the shape, size, etc of the selected image
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_image != null) {
                      var _Ifile = await EditImg(_image); // function called from EditImg.dart
                      if (_Ifile != null) {
                        setState(() {
                          _image = _Ifile;
                        });
                      }
                    } else {
                      Fluttertoast.showToast(
                          msg: "Select a image first :-(",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  }),
              Spacer(
                flex: 2,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Spacer(
                flex: 2,
              ),
              RaisedButton(
                  color: Colors.greenAccent[400],
                  child: Text(
                    'Apply Filters', //to start apply various photo filters to the selected image
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_image != null) {
                      var _Ifile = await ApplyFilters(context, _image); // function called from ApplyFilters.dart
                      if (_Ifile != null) {
                        setState(() {
                          _image = _Ifile;
                        });
                      }
                    } else {
                      Fluttertoast.showToast(
                          msg: "Select a image first :-(",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  }),
              Spacer(
                flex: 1,
              ),
              RaisedButton(
                  color: Colors.greenAccent[400],
                  child: Text(
                    'Download Editted image', //to save the edited  image to gallery
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_image != null) {
                      await SaveImg(_image); // function called from SaveInGallery.dart
                    } else {
                      Fluttertoast.showToast(
                          msg: "Select a image first :-(",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  }),
              Spacer(
                flex: 2,
              ),
            ],
          ),
        ],
      )),
    );
  }
}
