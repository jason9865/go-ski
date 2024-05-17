import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends GetxController {
    final picker = ImagePicker();

    Future<XFile?> getImage() {
      return picker.pickImage(source: ImageSource.gallery);
    }

    Future<List<XFile?>> getMultiImage() {
      return picker.pickMultiImage();
    }
}
