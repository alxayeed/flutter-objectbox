import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';


class FileManager{
  static Future<Uint8List?> captureImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      return await pickedFile.readAsBytes();
    }

    return null;
  }


  static Future<Uint8List?> pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return await pickedFile.readAsBytes();
    }

    return null;
  }

}