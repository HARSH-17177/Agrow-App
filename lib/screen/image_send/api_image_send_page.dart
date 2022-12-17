import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:jit_gaye_hackathon/screen/result/result.dart';

class Solution extends StatefulWidget {
  const Solution({super.key});

  @override
  State<Solution> createState() => _SolutionState();
}

class _SolutionState extends State<Solution> {
  bool dataThere = true;
  File? selectedImage;
  String message = '';

  uploadImage() async {
    dataThere = false;
    setState(() {});
    final request = http.MultipartRequest(
        "POST", Uri.parse("https://fd31-103-169-236-82.in.ngrok.io/upload"));
    final headers = {"Content-type": "multipart/form-data"};
    request.files.add(http.MultipartFile('image',
        selectedImage!.readAsBytes().asStream(), selectedImage!.lengthSync(),
        filename: selectedImage!.path.split("/").last));
    request.headers.addAll(headers);
    final response = await request.send();
    http.Response res = await http.Response.fromStream(response);
    final resJson = jsonDecode(res.body);

    setState(() {
      dataThere = true;
    });
    // print(resJson);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Result(
          dis1: resJson['disease 1'],
          dis2: resJson['disease 2'],
          dis3: resJson['disease 3']),
    ));
  }

  Future getImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    selectedImage = File(pickedImage!.path);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Solution"),
      ),
      body: (dataThere == false)
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  selectedImage == null
                      ? const Text("Please pick a image to upload")
                      : Image.file(selectedImage!),
                  TextButton.icon(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue)),
                      onPressed: uploadImage,
                      icon: const Icon(
                        Icons.upload_file,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Upload",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}
