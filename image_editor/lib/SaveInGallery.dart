import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:fluttertoast/fluttertoast.dart';

SaveImg(_image)async{
  var result=await GallerySaver.saveImage(_image.path,albumName: 'ImageEditor').then((bool success) {
    success?Fluttertoast.showToast(
        msg:
        "Image saved in gallery/ImageEditor",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green[400],
        textColor: Colors.white,
        fontSize: 16.0):
    Fluttertoast.showToast(
        msg:
        "Something went wrong try again plz!!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green[400],
        textColor: Colors.white,
        fontSize: 16.0);
  });
}