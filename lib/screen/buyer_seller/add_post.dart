import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  bool loading = false;
  final user = FirebaseAuth.instance.currentUser!;

  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerQuantity = TextEditingController();
  TextEditingController _controllerUrl = TextEditingController();

  GlobalKey<FormState> key = GlobalKey();

  CollectionReference _reference =
      FirebaseFirestore.instance.collection('shopping_list');

  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sell and Buy'),
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
                    const InputDecoration(hintText: 'Enter Post Headline'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Post Headline';
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
                decoration:
                    const InputDecoration(hintText: 'Enter your whatappurl'),
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
                    //Import dart:core
                    String uniqueFileName =
                        DateTime.now().millisecondsSinceEpoch.toString();

                    /*Step 2: Upload to Firebase storage*/
                    //Install firebase_storage
                    //Import the library

                    //Get a reference to storage root
                    Reference referenceRoot = FirebaseStorage.instance.ref();
                    Reference referenceDirImages =
                        referenceRoot.child('images');

                    //Create a reference for the image to be stored
                    Reference referenceImageToUpload =
                        referenceDirImages.child('name');

                    //Handle errors/success
                    try {
                      //Store the file
                      await referenceImageToUpload.putFile(File(file.path));
                      //Success: get the download URL
                      imageUrl = await referenceImageToUpload.getDownloadURL();
                    } catch (error) {
                      //Some error occurred
                    }
                  },
                  icon: const Icon(Icons.camera_alt)),
              ElevatedButton(
                  onPressed: () async {
                    if (imageUrl.isEmpty) {
                      setState(() {
                        loading = true;
                      });
                      return;
                    }

                    if (key.currentState!.validate()) {
                      setState(() {
                        loading = false;
                      });
                      String itemName = _controllerName.text;
                      String itemQuantity = _controllerQuantity.text;
                      String url = _controllerUrl.text;

                      //Create a Map of data
                      Map<String, String> dataToSend = {
                        'user': user.email.toString(),
                        'name': itemName,
                        'quantity': itemQuantity,
                        'url': url,
                        'image': imageUrl,
                      };

                      //Add a new item
                      _reference.add(dataToSend);
                      Navigator.pop(context);
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
