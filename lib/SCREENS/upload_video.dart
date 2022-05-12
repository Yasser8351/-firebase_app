import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class UploadVideo extends StatefulWidget {
  const UploadVideo({Key? key}) : super(key: key);

  @override
  State<UploadVideo> createState() => _UploadVideoState();
}

class _UploadVideoState extends State<UploadVideo> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        pickedFile = result.files.first;
      });
    } else {
      return;
    }
  }

  Future uplaodFile() async {
    final path = "file/${pickedFile!.name}";
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask!.whenComplete(() => {});
    final urlDownload = snapshot.ref.getDownloadURL();
    log(urlDownload.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          pickedFile != null
              ? Container(
                  child: Image(image: FileImage(File(pickedFile!.path!))),
                  color: Colors.grey,
                  height: 200,
                  width: double.infinity,
                )
              : const SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Image(
                    image: AssetImage('assets/placeholder.png'),
                    fit: BoxFit.fitHeight,
                  ),
                ),
          ElevatedButton(
              onPressed: selectFile, child: const Text("Select Image")),
          ElevatedButton(
              onPressed: uplaodFile, child: const Text("Upload Image")),
        ],
      ),
    );
  }
}
