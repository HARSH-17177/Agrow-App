import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jit_gaye_hackathon/discussionPage/Landing.dart';
import 'package:jit_gaye_hackathon/discussionPage/updateProfile.dart';

class Auth {
  static Future login(email, password, BuildContext context) async {
    final _auth = FirebaseAuth.instance;
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LandingPAge()));
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  static Future signup(email, password, BuildContext context) async {
    final _auth = FirebaseAuth.instance;
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UpdateProfile()));
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      print(e);
    }
  }

  static Future updateProfile({name, context, image}) async {
    final _auth = FirebaseAuth.instance;

    try {
      await _auth.currentUser!.updateDisplayName(name);
      await _auth.currentUser!.updatePhotoURL(image);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LandingPAge()));
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      print(e);
    }
  }

  static Future uploadPick() async {
    final _storage = FirebaseStorage.instance;
    var url;
    try {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
      await _storage.ref(image!.name).putFile(File(image.path)).then((p0) {
        url = p0.ref.getDownloadURL();
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      print(e);
    }

    return url;
  }
}
