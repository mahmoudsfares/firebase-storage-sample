import 'package:firebase_storage_sample/ui/my_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyScreen extends GetView {

  final MyController _controller = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () => _controller.selectFile(),
                    child: const Text('Select File')),
                const SizedBox(height: 8),
                Obx(
                  () => Text(
                    _controller.file.value.path,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 48),
                ElevatedButton(
                    onPressed: () => _controller.uploadFile(),
                    child: const Text('Upload File')),
                const SizedBox(height: 20),
                Obx(() => Text(
                    _controller.uploadProgress.value,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
