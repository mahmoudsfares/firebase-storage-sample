import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MyService {

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    final path = result.files.single.path!;
    return File(path);
  }

  Stream<TaskSnapshot> uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      UploadTask task =  ref.putFile(file);
      return task.snapshotEvents;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

}