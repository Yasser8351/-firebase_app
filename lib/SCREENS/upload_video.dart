import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  final _form = GlobalKey<FormState>();
  final _passwordFocus = FocusNode();
  final _videoNameController = TextEditingController();
  final _descripstionController = TextEditingController();
  bool isLoading = false;

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
    try {
      setState(() {
        isLoading = true;
      });
      final isValid = _form.currentState!.validate();
      if (!isValid) {
        return null;
      }
      _form.currentState!.save();
      final path = "file/${pickedFile!.name}";
      final file = File(pickedFile!.path!);

      final ref = FirebaseStorage.instance.ref().child(path);
      uploadTask = ref.putFile(file);
      final snapshot = await uploadTask!.whenComplete(() => {});
      var url = "";

      final urlDownload = snapshot.ref.getDownloadURL().then((value) {
        FirebaseFirestore.instance
            .collection("videos")
            .doc(DateTime.now().toString() + url.toString())
            .set(
          {
            "name_video": _videoNameController.text,
            "descripstion_video": _descripstionController.text,
            "video_url": value.toString(),
            "time": DateTime.now()
          },
        );
        setState(() {
          log(value);

          value = url;
        });
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text(" تم رفع الفيديو")));
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("حدث خطأ اثناء رفع الفيديو")));
    }

    /*
    on FirebaseAuthException catch (error)
    */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                  key: _form,
                  child: Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: SizedBox(
                      height: 251,
                      child: ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          Container(
                            color: Colors.white,
                            child: TextFormField(
                              textAlign: TextAlign.left,
                              controller: _videoNameController,
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                  labelText: 'title',
                                  focusColor: Colors.white,
                                  hoverColor: Colors.white,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  )),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_passwordFocus);
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'يجب ادخال عنوان الفيديو ';
                                }
                                return null;
                              },
                              onSaved: (value) {},
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            color: Colors.white,
                            child: TextFormField(
                              textAlign: TextAlign.left,
                              controller: _descripstionController,
                              decoration: InputDecoration(
                                  labelText: 'decoration',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  )),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_passwordFocus);
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'يجب ادخال الوصف';
                                }
                                return null;
                              },
                              onSaved: (value) {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                pickedFile != null
                    ? GestureDetector(
                        onTap: () {
                          selectFile();
                        },
                        child: Container(
                          child:
                              const Center(child: Text("تم ارفاق الملف بنجاح")),
                          // Image(image: FileImage(File(pickedFile!.path!))),
                          color: Colors.grey,
                          height: 200,
                          width: double.infinity,
                        ),
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
                    onPressed: selectFile, child: const Text("Select File")),
                ElevatedButton(
                    onPressed: uplaodFile, child: const Text("Upload File")),
              ],
            ),
    );
  }
}
