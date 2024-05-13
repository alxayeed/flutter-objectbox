import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
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

  static Future<Uint8List?> pickFileFromStorage() async {
    try {
      final result = await FilePicker.platform.pickFiles();

      if (result != null && result.files.isNotEmpty) {
        final bytes = result.files.first.bytes;

        return bytes;
      } else {
        return null;
      }
    } catch (e) {
      print('Error picking file: $e');
      return null;
    }
  }

}