import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage_sample/ui/my_service.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

class MyController extends GetxController {
  MyService service = MyService();

  List<File> pendingUploads = List<File>.empty(growable: true);
  RxString uploadProgress = ''.obs;
  RxInt error = 1.obs;
  late StreamSubscription uploadSubscription;

  void selectFile() async {
    dynamic myFile = await service.selectFile();

    if (myFile is File) {
      if (pendingUploads.length <= 1) {
        pendingUploads.add(myFile);
        if (pendingUploads.length == 1) startUploading();
      } else {
        if (error.value == 1)
          error.value = 2;
        else
          error.value = 1;
      }
    }
  }

  void startUploading() {
    if (pendingUploads.isEmpty) return;

    File file = pendingUploads.first;
    String fileName = basename(file.path);
    String destination = 'files/$fileName';

    Stream<TaskSnapshot> stream = service.uploadFile(destination, file);
    uploadSubscription = stream.listen((taskSnapshot) {
      double progress = taskSnapshot.bytesTransferred / taskSnapshot.totalBytes;
      String percentage = (progress * 100).toStringAsFixed(2);
      if (percentage == '100.00') {
        uploadProgress.value = 'Upload complete!';
        pendingUploads.removeAt(0);
        uploadSubscription.cancel();
        if (pendingUploads.isNotEmpty) {
          startUploading();
        }
      } else
        uploadProgress.value = '$percentage%';
    });
  }
}
