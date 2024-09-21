import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends GetxController{
  //picked image
  var image = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    } else {
      if (kDebugMode) {
        print('No image selected.');
      }
    }
  }
}