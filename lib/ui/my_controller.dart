import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage_sample/ui/my_service.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

class MyController extends GetxController {

  MyService service = MyService();

  Rx<File> file = File('').obs;
  RxString uploadProgress = ''.obs;


  void selectFile() async {
    file.value = await service.selectFile();
    uploadProgress.value = '';
  }

  void uploadFile() {

    if (file.value.path == '') return;

    String fileName = basename(file.value.path);
    String destination = 'files/$fileName';

    Stream<TaskSnapshot> stream = service.uploadFile(destination, file.value);
    stream.listen((taskSnapshot) {
      double progress = taskSnapshot.bytesTransferred / taskSnapshot.totalBytes;
      String percentage = (progress * 100).toStringAsFixed(2);
      if(percentage == '100.00')
        uploadProgress.value = 'Upload complete!';
      else
        uploadProgress.value = '$percentage%';
    });
  }
}