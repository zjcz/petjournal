import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

/// Service to help manage image selection
class ImageService {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      return File(pickedFile.path);
    }

    return null;
  }

  Future<String> saveImage(String imagePath) async {
    final File imageFile = File(imagePath);
    if (!(await imageFile.exists())) {
      return '';
    }

    final Directory appDir = await getApplicationDocumentsDirectory();
    final String fileName = imageFile.path.split('/').last;
    final String savedImagePath =
        '${appDir.path}/${DateTime.now().toIso8601String()}_$fileName';
    await imageFile.copy(savedImagePath);

    return savedImagePath;
  }

  Future<void> deleteImage(String imagePath) async {
    final File imageFile = File(imagePath);

    if (await imageFile.exists()) {
      await imageFile.delete();
    }
  }
}
