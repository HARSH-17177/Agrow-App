import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class BorrowAdd extends StatefulWidget {
  const BorrowAdd({Key? key}) : super(key: key);

  @override
  State<BorrowAdd> createState() => _BorrowAddState();
}

class _BorrowAddState extends State<BorrowAdd> {
  bool loading = false;
  final user = FirebaseAuth.instance.currentUser!.email.toString();

  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerQuantity = TextEditingController();
  TextEditingController _controllerUrl = TextEditingController();

  GlobalKey<FormState> key = GlobalKey();

  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('borrow');

  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Borrow or Lend'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: key,
          child: Column(
            children: [
              TextFormField(
                controller: _controllerName,
                decoration:
                    const InputDecoration(hintText: 'Enter the Equipment name'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Equipment name';
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: _controllerQuantity,
                decoration:
                    const InputDecoration(hintText: 'Enter its Description'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter its Description';
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: _controllerUrl,
                decoration: const InputDecoration(
                    hintText: 'Enter your whatapp number'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter the whatsAppUrl';
                  }

                  return null;
                },
              ),
              IconButton(
                  onPressed: () async {
                    /*
                * Step 1. Pick/Capture an image   (image_picker)
                * Step 2. Upload the image to Firebase storage
                * Step 3. Get the URL of the uploaded image
                * Step 4. Store the image URL inside the corresponding
                *         document of the database.
                * Step 5. Display the image on the list
                *
                * */

                    /*Step 1:Pick image*/
                    //Install image_picker
                    //Import the corresponding library

                    ImagePicker imagePicker = ImagePicker();
                    XFile? file =
                        await imagePicker.pickImage(source: ImageSource.camera);
                    print('${file?.path}');

                    if (file == null) return;
                    String uniqueFileName =
                        DateTime.now().microsecondsSinceEpoch.toString();
                    Reference referenceRoot = FirebaseStorage.instance.ref();
                    Reference referenceDirImages =
                        referenceRoot.child('images');

                    //Create a reference for the image to be stored
                    Reference referenceImageToUpload =
                        referenceDirImages.child(uniqueFileName);
                    if (imageUrl.isEmpty) {
                      setState(() {
                        loading = true;
                      });
                    }
                    //Handle errors/success
                    try {
                      UploadTask task =
                          referenceImageToUpload.putFile(File(file.path));
                      //Store the file

                      //Success: get the download URL
                      task.whenComplete(() async {
                        imageUrl =
                            await referenceImageToUpload.getDownloadURL();
                        setState(() {
                          loading = false;
                        });
                      });
                    } catch (error) {
                      //Some error occurred
                    }
                  },
                  icon: const Icon(Icons.camera_alt)),
              ElevatedButton(
                  onPressed: () async {
                    if (key.currentState!.validate()) {
                      String itemName = _controllerName.text;
                      String itemQuantity = _controllerQuantity.text;
                      String url = "https://wa.me/+91${_controllerUrl.text}";

                      //Create a Map of data
                      Map<String, String> dataToSend = {
                        'user': user,
                        'name': itemName,
                        'quantity': itemQuantity,
                        'url': url,
                        'image': imageUrl,
                        'timestamp': DateTime.now().toString(),
                      };

                      //Add a new item
                      _reference.add(dataToSend);
                      if (imageUrl.isNotEmpty) {
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: const Text('Submit')),
              const SizedBox(
                height: 40,
              ),
              (loading == true)
                  ? const CircularProgressIndicator()
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
