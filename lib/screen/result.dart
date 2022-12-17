import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  String dis1, dis2, dis3;
  Result(
      {super.key, required this.dis1, required this.dis2, required this.dis3});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(35),
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Disease 1 :",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                dis1,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Disease 2 :",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                dis2,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Disease 3 :",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                dis3,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
