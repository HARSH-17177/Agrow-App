import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jit_gaye_hackathon/discussionPage/Brain/Auth.dart';

class UpdateProfile extends StatefulWidget {
  UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final nameDecoration = InputDecoration(
      hintText: 'Enter Your Name',
      hintStyle: GoogleFonts.alice(color: Colors.white),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)));

  final controller = TextEditingController();

  var image;
  bool visibility = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 50),
        child: Stack(
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Complete \n profile.",
                    style: GoogleFonts.alice(color: Colors.white, fontSize: 40),
                  ),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        visibility = true;
                      });
                      await Auth.uploadPick().then((value) {
                        setState(() {
                          image = value;
                        });
                      });
                      setState(() {
                        visibility = false;
                      });
                    },
                    child: CircleAvatar(
                      backgroundImage:
                          image != null ? NetworkImage(image) : null,
                      backgroundColor: Colors.grey,
                      radius: 50,
                    ),
                  ),
                  Container(),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: controller,
                          decoration: nameDecoration,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          onPressed: () {
                            setState(() {
                              visibility = true;
                            });
                            Auth.updateProfile(
                                name: controller.text.trim(),
                                context: context,
                                image: image);
                            setState(() {
                              visibility = false;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'Next',
                              style: GoogleFonts.alice(fontSize: 16),
                            ),
                          ),
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Container()
                ]),
            Center(
              child: Visibility(
                  visible: visibility,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
