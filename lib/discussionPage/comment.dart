import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Comments extends StatefulWidget {
  final postid;
  const Comments({Key? key, this.postid}) : super(key: key);

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final commentDecoration = InputDecoration(
      hintText: 'Write Comment.....',
      hintStyle: GoogleFonts.alice(color: Colors.white),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)));
  final comment = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
        backgroundColor: Colors.blueAccent,
      ),
      backgroundColor: Colors.blueAccent,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder(
                  stream: _firestore
                      .collection('Posts')
                      .doc(widget.postid)
                      .collection('Comments')
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    List<Widget> cards = [];
                    if (snapshot.hasData) {
                      snapshot.data!.docs.forEach((element) {
                        cards.add(Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 15,
                                        backgroundImage: NetworkImage(
                                            element['UploaderImage']),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(element['Uploader']),
                                      )
                                    ],
                                  ),
                                ),
                                Divider(),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(element['Comment']),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ));
                      });
                    }
                    return Column(
                      children: cards,
                    );
                  }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onSubmitted: (a) async {
                    var name = _auth.currentUser!.displayName;
                    var uploaderImage = _auth.currentUser!.photoURL;
                    await _firestore
                        .collection('Posts')
                        .doc(widget.postid)
                        .collection('Comments')
                        .add({
                      'Uploader': name,
                      'UploaderImage': uploaderImage,
                      'Comment': a,
                    });
                  },
                  controller: comment,
                  decoration: commentDecoration,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
