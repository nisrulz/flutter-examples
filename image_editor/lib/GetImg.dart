import 'package:image_picker/image_picker.dart';
import 'dart:io';


GetiImg(_image)async{
  var pickedFile=await ImagePicker().getImage(source: ImageSource.gallery);
  if(pickedFile!=null){
     _image=File(pickedFile.path);
    return _image;
  }
  else{
    return null;
  }

}