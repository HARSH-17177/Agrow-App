import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jit_gaye_hackathon/constants.dart';
import 'package:jit_gaye_hackathon/screen/api/image.dart';

class LatestNews extends StatefulWidget {
  const LatestNews({super.key});

  @override
  State<LatestNews> createState() => _LatestNewsState();
}

class _LatestNewsState extends State<LatestNews> {
  @override
  void initState() {
    apicall();
    super.initState();
  }

  Future apicall() async {
    http.Response response;
    response = await http.get(Uri.parse(
        "https://newsdata.io/api/1/news?apikey=pub_14690480cd46de7fd1c3600f7a172b7bc3e2c&q=agriculture&country=in"));
    if (response.statusCode == 200) {
      setState(() {
        stringResponse = response.body;
        mapResponse = jsonDecode(response.body);
        listResponse = mapResponse['results'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('News Api')),
      body: (listResponse.isEmpty)
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.blueAccent,
              ),
            )
          : ListView.builder(
              itemCount: listResponse.isEmpty ? 0 : listResponse.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Card(
                          elevation: 10,
                          shadowColor: Colors.greenAccent,
                          color: Colors.green,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                (listResponse[index]['image_url'] == null)
                                    ? GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Imaging(
                                                        url: link,
                                                        tex: listResponse[index]
                                                            ['description'],
                                                      )));
                                        },
                                        child: Image.network(link),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Imaging(
                                                        url: listResponse[index]
                                                            ['image_url'],
                                                        tex: listResponse[index]
                                                            ['description'],
                                                      )));
                                        },
                                        child: Image.network(
                                            listResponse[index]['image_url'])),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  listResponse[index]['title'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ],
                );
              }),
    );
  }
}
