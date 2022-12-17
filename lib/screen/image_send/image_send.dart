import 'package:flutter/material.dart';
import 'package:jit_gaye_hackathon/screen/image_send/api_image_send_page.dart';
import 'package:jit_gaye_hackathon/screen/image_send/api_soil.dart';

class ImageSendOption extends StatelessWidget {
  const ImageSendOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Solution(),
                      ));
                },
                icon: Icon(
                  Icons.energy_savings_leaf_outlined,
                  color: Colors.green[900],
                ),
                label: Text(
                  'Leaf Check',
                  style: TextStyle(color: Colors.green[900]),
                )),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Soil(),
                      ));
                },
                icon: const Icon(
                  Icons.dirty_lens_outlined,
                  color: Colors.brown,
                ),
                label: const Text(
                  'Soil Check',
                  style: TextStyle(color: Colors.brown),
                )),
          ],
        ),
      ),
    );
  }
}
