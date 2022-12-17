import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PostService {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  createPost(title, url) async {
    var name = _auth.currentUser!.displayName;
    var image = _auth.currentUser!.photoURL;
    var id = DateTime.now();
    Post post = Post(_auth.currentUser!.displayName,
        _auth.currentUser!..photoURL, title, url);
    try {
      await _firestore.collection('Posts').doc(id.toString()).set({
        'uploader': name,
        'uploaderImage': image,
        'title': title,
        'photo': url,
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      print(e);
    }
  }
}

class Post {
  final uploader;
  final uploaderImage;
  final title;
  final photo;
  Post(this.uploader, this.uploaderImage, this.title, this.photo);
}
