import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

EditImg(_image) async {
  var CroppedImg = await ImageCropper()
      .cropImage(sourcePath: _image.path, aspectRatioPresets: [
    CropAspectRatioPreset.square,
    CropAspectRatioPreset.ratio3x2,
    CropAspectRatioPreset.original,
    CropAspectRatioPreset.ratio4x3,
    CropAspectRatioPreset.ratio16x9
  ], uiSettings: [
    AndroidUiSettings(
        toolbarTitle: 'Cropper',
        toolbarColor: Colors.greenAccent[400],
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false),
    IOSUiSettings(
      minimumAspectRatio: 1.0,
    ),
  ]);
  if (CroppedImg != null) {
    _image = CroppedImg;
    return _image;
  } else
    return null;
}
