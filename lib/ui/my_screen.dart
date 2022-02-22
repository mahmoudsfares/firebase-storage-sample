import 'package:firebase_storage_sample/ui/my_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class MyScreen extends GetView {

  final MyController _controller = Get.put(MyController());

  @override
  Widget build(BuildContext context) {
    _controller.error.listen((p0) {
      Fluttertoast.showToast(msg: 'can\'t upload more than two videos');
    });
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
                    child: const Text('Select file to upload')),
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
