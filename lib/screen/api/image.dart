import 'package:flutter/material.dart';

class Imaging extends StatelessWidget {
  late String url;
  late String tex;
  Imaging({super.key, required this.url, required this.tex});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'tag',
      child: Scaffold(
        appBar: AppBar(title: const Text('Image')),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                elevation: 10,
                shadowColor: Colors.greenAccent,
                color: Colors.green,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Image.network(url),
                ),
              ),
              Card(
                  elevation: 10,
                  shadowColor: Colors.greenAccent,
                  color: Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(tex,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white)),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
