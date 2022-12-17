import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var data;
  getProfile() async {
    final _auth = FirebaseAuth.instance;
    try {
      setState(() {
        data = _auth.currentUser;
      });
    } catch (e) {}
  }

  @override
  void initState() {
    getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(20.0),
            //   child: CircleAvatar(
            //     radius: 70,
            //     backgroundImage: NetworkImage(data.photoURL),
            //   ),
            // ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  FirebaseAuth.instance.currentUser!.displayName.toString(),
                  style: GoogleFonts.alice(color: Colors.white),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    'Email : ${FirebaseAuth.instance.currentUser!.email}',
                    style: GoogleFonts.alice(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
