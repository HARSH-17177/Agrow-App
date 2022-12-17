import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jit_gaye_hackathon/discussionPage/Brain/Auth.dart';

class Signup extends StatefulWidget {
  Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  final emailDecoration = InputDecoration(
      hintText: 'Enter Email',
      hintStyle: GoogleFonts.alice(color: Colors.white),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)));

  final passwordDecoration = InputDecoration(
      hintText: 'Enter Password',
      hintStyle: GoogleFonts.alice(color: Colors.white),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)));

  final confirmPasswordDecoration = InputDecoration(
      hintText: 'Enter Password',
      hintStyle: GoogleFonts.alice(color: Colors.white),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)));
  bool visibility = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.blueAccent,
        body: Stack(
          children: [
            SingleChildScrollView(
                child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 70),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Signup.",
                      style:
                          GoogleFonts.alice(color: Colors.white, fontSize: 50),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: emailController,
                            decoration: emailDecoration,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: passwordController,
                            decoration: passwordDecoration,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: confirmPasswordController,
                            decoration: confirmPasswordDecoration,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MaterialButton(
                            minWidth: double.infinity,
                            onPressed: () async {
                              setState(() {
                                visibility = true;
                              });
                              if (passwordController.text ==
                                  confirmPasswordController.text) {
                                await Auth.signup(emailController.text.trim(),
                                    passwordController.text, context);
                              } else {
                                Fluttertoast.showToast(
                                    msg: 'Password did not matched');
                              }
                              setState(() {
                                visibility = false;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                'Signup',
                                style: GoogleFonts.alice(fontSize: 16),
                              ),
                            ),
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MaterialButton(
                            minWidth: double.infinity,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                'Go Back',
                                style: GoogleFonts.alice(fontSize: 16),
                              ),
                            ),
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )),
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
