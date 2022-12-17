import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jit_gaye_hackathon/discussionPage/Brain/Auth.dart';
import 'package:jit_gaye_hackathon/discussionPage/signup.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final emailDecoration = InputDecoration(
      hintText: 'Enter Email',
      hintStyle: GoogleFonts.alice(color: Colors.white),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)));

  final passwordDecoration = InputDecoration(
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
                      "Login.",
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
                        Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  'ForgotPassword ? ',
                                  style: GoogleFonts.alice(color: Colors.white),
                                )))
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
                              await Auth.login(emailController.text.trim(),
                                  passwordController.text.trim(), context);
                              setState(() {
                                visibility = false;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                'Login',
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Signup()));
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
